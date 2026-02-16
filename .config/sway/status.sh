#!/bin/bash

# TODO Reduce the number of sub-shells executed
#      Try to replace by built-in operations

# Inspiration from:
#   https://unix.stackexchange.com/questions/473788/simple-swaybar-example
#   https://gist.githubusercontent.com/Ultra-Code/172bc21008062effb89780341cf56922/raw/0c73ba93364c5a1e1034e3e785fce19d8d069760/statusbar.zsh

# utf icon list
#   https://gist.github.com/BuonOmo/77b75349c517defb01ef1097e72227af

STATUS_BAR_PATH="$(mktemp --tmpdir=/tmp swaybar.XXXXXXX)"
PID_BACKGROUND=0

# trap '[ ! -e "${STATUS_BAR_PATH}" ] || rm -f "${STATUS_BAR_PATH}"; [ ${PID_BACKGROUND} -eq 1 ] || kill ${PID_BACKGROUND}' TERM EXIT ERR
trap '[ ! -e "${STATUS_BAR_PATH}" ] || rm -f "${STATUS_BAR_PATH}"; [ ${PID_BACKGROUND} -eq 1 ] || kill ${PID_BACKGROUND}' TERM ERR INT QUIT HUP KILL ABRT

# Fomat uptime
uptime_formatted() {
  local UPTIME
  read -a UPTIME < <(uptime)
  if [ "${UPTIME[2]}" == "${UPTIME[2]%%:*}" ]; then
    printf "↑%s %s" "${UPTIME[2]}" "${UPTIME[3]%%,*}"
  else
    printf "↑%s" "${UPTIME[2]%%,*}"
  fi
}

# Format date
date_formatted() {
  printf "📆 %s" "$(date "+%a %d-%b-%Y %H:%M")"
}

# Get the Linux version
linux_version() {
  local UNAME="$(uname -r)"
  UNAME="${UNAME%%-*}"
  printf "%s" "${UNAME}"
}

discover_battery_path() {
  for item in /sys/class/power_supply/*-battery; do
    printf "%s" "${item}"
    return 0
  done
  return 1
}

discover_ac_path() {
  for item in /sys/class/power_supply/*-ac; do
    printf "%s" "${item}"
    return 0
  done
  return 1
}

# Battery information
battery_info() {
  local battery_path="$(discover_battery_path)"
  local ac_path="$(discover_ac_path)"

  if [ "${battery_path}" == "" ] || [ "${ac_path}" == "" ]; then
    printf "⚡unknown"
    return 1
  fi

  local battery_status
  local ac_online
  local battery_capacity

  read -r battery_status < "${battery_path}/status"
  read -r ac_online < "${ac_path}/online"
  read -r battery_capacity < "${battery_path}/capacity"

  # Icon ac adapter connected or battery
  if [ "${ac_online}" == "1" ]; then
    printf "🔌"
  else
    printf "⚡"
  fi

  # Icon charging / discharging
  if [ "${battery_status}" == "Charging" ]; then
    printf "↑"
  elif [ "${battery_status}" == "Discharging" ]; then
    printf "↓"
  fi

  # Capacity icon
  if [ ${battery_capacity} -lt 10 ]; then
    printf ""
  elif [ ${battery_capacity} -lt 30 ]; then
    printf ""
  elif [ ${battery_capacity} -lt 70 ]; then
    printf ""
  elif [ "${battery_capacity}" -lt 90 ]; then
    printf ""
  else
    printf ""
  fi
  printf "%s%%" "${battery_capacity}"
}

brightness_info() {
  local brightness_path="/sys/class/backlight/apple-panel-bl"

  local brightness_max
  read -r brightness_max < "${brightness_path}/max_brightness"

  local brightness_value
  read -r brightness_value < "${brightness_path}/actual_brightness"

  # local brightness=$(( (100 * brightness_value) / brightness_max ))
  local brightness=$(( (100 * brightness_value) / brightness_max ))

  # printf "💻"
  # if [[ $brightness -le 25 ]];then
  #   printf "🔦%s%%" "$brightness"
  # elif [[ $brightness -le 50 ]];then
  #   printf "💡%s%%" "$brightness"
  # elif [[ $brightness -le 75 ]];then
  #   printf "🚦%s%%" "$brightness"
  # else
  #   printf "☀️ %s%%" "$brightness"
  # fi

  printf "💡%s%%" "$brightness"
  return 0
}

cpu_info() {
  # See: filesystems/proc.rst  at Linux Kernel Documentation
  local previous_idle_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+\s+){3}([[:digit:]]+).*|\2|p')
  local previous_system_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+\s+){2}([[:digit:]]+).*|\2|p')
  local previous_user_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+).*|\1|p')
  local previous_total_time=$(( previous_idle_time + previous_system_time + previous_user_time ))
  sleep 0.3
  local current_idle_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+\s+){3}([[:digit:]]+).*|\2|p')
  local current_system_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+\s+){2}([[:digit:]]+).*|\2|p')
  local current_user_time=$(head -n 1 /proc/stat | sed -En 's|^\w+\s+([[:digit:]]+).*|\1|p')
  local current_total_time=$(( current_idle_time + current_system_time + current_user_time ))

  local idle_time=$((current_idle_time - previous_idle_time))
  local total_time=$((current_total_time - previous_total_time))

  local usage=$(( 1000 - ((1000*idle_time)/total_time) ))
  local usage_main="$(( usage / 10 ))"
  local usage_decimal="$(( usage - usage_main * 10))"
  printf " %d.%d" "${usage_main}" "${usage_decimal}"
}

mem_info() {
  local info="$(free -m | grep -E '^Mem')"
  read -a fields < <(printf "%s" "$info")
  local total="${fields[1]}"
  local free="${fields[3]}"
  local buff_cache="${fields[5]}"
  local utilization=$((100 - ( (free+buff_cache) * 100 / total ) ))

  # local mem_used=$(echo $info | sed -E 's|[[:graph:]]+[[:space:]]+[[:digit:]]+[[:space:]]+([[:digit:]]+).*|\1|')
  local mem_used="${fields[2]}"
  local mem_used_decimal=$(( (mem_used % 1024) / 100 ))
  mem_used=$(( mem_used / 1024 ))

  printf " %d.%d GiB(%d)%%" "${mem_used}" "${mem_used_decimal}" "${utilization}"
}

net_first_bytes_received=0
net_first_bytes_transmited=0
net_first_time=0
net_second_bytes_received=0
net_second_bytes_transmited=0
net_second_time=0

check_network_connectivity() {
  readarray -s 1 -t arp_entries < /proc/net/arp
  if [ "${#arp_entries[@]}" -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

network_info() {
  local net_line
  # ignore the header and loopback device
  local bytes_received
  local bytes_transmited
  local field_bytes_received
  local field_bytes_transmited
  local rate_transmited
  local rate_received
  local no_network

  net_first_bytes_received=$net_second_bytes_received
  net_first_bytes_transmited=$net_second_bytes_transmited
  net_first_time=$net_second_time

  if check_network_connectivity; then
    no_network=0
  else
    no_network=1
  fi

  bytes_received=0
  bytes_transmited=0
  net_second_time=$(( $(date +%s%N) / 10000000 ))
  readarray -s 3 -t net_dev_lines < /proc/net/dev
  if [ ${#net_dev_lines[@]} -eq 0 ]; then
    rate_received=0
    rate_transmited=0
  else
    for net_line in "${net_dev_lines[@]}"; do
      field_bytes_received="$(printf "$net_line" | awk '{ print $2 }')"
      field_bytes_transmited="$(printf "$net_line" | awk '{ print $10 }')"
      bytes_received=$((bytes_received + field_bytes_received))
      bytes_transmited=$((bytes_transmited + field_bytes_transmited))
    done
    net_second_bytes_received="$bytes_received"
    net_second_bytes_transmited="$bytes_transmited"
    if [ $net_first_time -eq 0 ]; then
      rate_received=0
      rate_transmited=0
    else
      rate_received="$(( (net_second_bytes_received - net_first_bytes_received)*100*8 / (net_second_time - net_first_time) ))"
      rate_transmited="$(( (net_second_bytes_transmited - net_first_bytes_transmited)*100*8 / (net_second_time - net_first_time) ))"
    fi

    received_units="bps"
    transmited_units="bps"

    if [ $rate_transmited -gt 1100 ]; then
      rate_transmited=$(( rate_transmited / 1000 ))
      transmited_units="kbps"
      if [ $rate_transmited -gt 1100 ]; then
        rate_transmited=$(( rate_transmited / 1000 ))
        transmited_units="mbps"
      fi
    fi

    if [ $rate_received -gt 1100 ]; then
      rate_received=$(( rate_received / 1000 ))
      received_units="kbps"
      if [ $rate_received -gt 1100 ]; then
        rate_received=$(( rate_received / 1000 ))
        received_units="mbps"
      fi
    fi
  fi

  if [ $no_network -eq 1 ]; then
    printf " --"
  else
    printf " ↑%s%s↓%s%s" "${rate_transmited}" "${transmited_units}" "${rate_received}" "${received_units}"
  fi
}

system_monitor_info() {
  cpu_info; printf " "; mem_info; printf " "; network_info
}

volume_info() {
  local default_sink="$(pactl get-default-sink)"
  local default_source="$(pactl get-default-source)"
  local is_muted
  local is_mic_muted
  local volume
  local volume_left
  local volume_right
  read -a is_muted < <(pactl get-sink-mute "${default_sink}")
  read -a is_mic_muted < <(pactl get-source-mute "${default_source}")
  is_muted="${is_muted[1]}"
  is_mic_muted="${is_mic_muted[1]}"
  if [ "${is_mic_muted}" == "no" ]; then
    printf "%s " "🎤"
  fi
  if [ "${is_muted}" == "yes" ]; then
    printf "%s" "🔇"
  else
    read -a volume < <(pactl get-sink-volume "${default_sink}")
    volume_left="${volume[4]%%%*}"
    volume_right="${volume[11]%%%*}"
    volume=$(( (volume_left + volume_right) / 2 ))
    if [ $volume -lt 33 ]; then
      printf "%s%s%%" "🔈" "${volume}"
    elif [ $volume -lt 66 ]; then
      printf "%s%s%%" "🔉" "${volume}"
    else
      printf "%s%s%%" "🔊" "${volume}"
    fi
  fi
}

playing_info() {
  local title=""
  which playerctl &>/dev/null || return 0
  if [ "$(playerctl status)" == "Playing" ]; then
    title="$(playerctl metadata title)"
    printf "%s %s | " "${title}" "🎵"
  fi
}

status_bar() {
  # It needs to avoid a sub-shell to keep the previous values for
  # the network bandwidth information

  exec 3>"${STATUS_BAR_PATH}"
  # FIXME The error message was get meanwhile playing the url: https://www.youtube.com/watch?v=TumXs9SUADA
  #       Related with playing_info
  #       Likely related with no escaped characters
  #       Commented until located
  # 00:01:02.439 [ERROR] [common/pango.c:66] pango_parse_markup 'Fito y Fitipaldis & Coque Malla - Ruido (Tributo a Sabina) [Videoclip Oficial] 🎵 | ↑1:05 |  5.3  8.1 GiB(11)%  ↑514bps↓514bps | 📆 Sun 15-Jun-2025 11:58 | ⚡↓33% 💡77% 🎤 🔉45%' -> error Error on line 1: Entity did not end with a semicolon; most likely you used an ampersand character without intending to start an entity — escape ampersand as &amp;

  # playing_info >&3; printf " | " >&3
  uptime_formatted >&3; printf " | " >&3
  system_monitor_info >&3; printf " | " >&3
  date_formatted >&3; printf " | " >&3
  battery_info >&3; printf " " >&3
  brightness_info >&3; printf " " >&3
  volume_info >&3
  printf "%s" "$(cat "${STATUS_BAR_PATH}" )"

  # echo "↑$(uptime_formatted) 🐧$(linux_version) 🔋$(batteryInfo) | $(date_formatted)"
  # 🐧$(linux_version) 🔋$(battery_info) | $(date_formatted)"
}

(while true; do
  status_bar
  sleep 1
done) &
PID_BACKGROUND="$!"

