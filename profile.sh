#!/bin/bash

# Color Codes
C_RESET="\e[0m"
C_KEY="\e[38;5;208m"      # Orange/Brown for keys
C_VAL="\e[38;5;117m"      # Light Blue/Cyan for values
C_DOT="\e[90m"            # Dark Gray for dots and dashes
C_USER="\e[38;5;117m"     # Light blue for username
C_DASH="\e[90m"           # Gray dashes
C_TITLE="\e[38;5;253m"    # Off-white for section titles
C_BRACE="\e[38;5;253m"    # Braces
C_PIPE="\e[90m"           # Pipes
C_GREEN="\e[38;5;40m"     # Green for ++
C_RED="\e[38;5;196m"      # Red for --

MAX_WIDTH=90
# Read DOB from .env file if it exists
if [ -f "$(dirname "$0")/.env" ]; then
    source "$(dirname "$0")/.env"
fi
DOB="${DOB:-1999-07-08}"  # Fallback format: YYYY-MM-DD

# Function to print a title with a calculated number of dashes
print_header() {
    local colored_text="$1"
    local plain_text="$2"
    local pad_len=$((MAX_WIDTH - ${#plain_text} - 1))
    
    # Generate dashes
    printf -v dashes '%*s' "$pad_len" ""
    dashes=${dashes// /-}
    
    echo -e "${colored_text} ${C_DASH}${dashes}${C_RESET}"
}

# Function to calculate exact uptime based on Date of Birth
calc_uptime() {
    local dob="$1"
    local y1=$(date -d "$dob" +%Y)
    local m1=$(date -d "$dob" +%-m)
    local d1=$(date -d "$dob" +%-d)
    
    local y2=$(date +%Y)
    local m2=$(date +%-m)
    local d2=$(date +%-d)
    
    local years=$((y2 - y1))
    local months=$((m2 - m1))
    local days=$((d2 - d1))
    
    if (( days < 0 )); then
        months=$((months - 1))
        local prev_month_days=$(date -d "$(date +%Y-%m-01) -1 day" +%d)
        days=$((10#$prev_month_days + days))
    fi
    
    if (( months < 0 )); then
        years=$((years - 1))
        months=$((months + 12))
    fi
    
    echo "$years years, $months months, $days days"
}

# Function to print a row with a calculated number of dots
print_row() {
    local key="$1"
    local val="$2"
    # Length calculation: ". " (2) + key + " " (1) + dots + " " (1) + val
    local text_len=$((${#key} + ${#val} + 4)) 
    local pad_len=$((MAX_WIDTH - text_len))
    
    # Generate dots
    printf -v dots '%*s' "$pad_len" ""
    dots=${dots// /.}
    
    echo -e "${C_DOT}.${C_RESET} ${C_KEY}${key}${C_RESET} ${C_DOT}${dots}${C_RESET} ${C_VAL}${val}${C_RESET}"
}

generate_profile() {
    print_header "${C_USER}devaraj@dev" "devaraj@dev"
    print_row "OS:" "Android 16, Debian 13"
    print_row "Uptime:" "$(calc_uptime "$DOB")"
    # print_row "Host:" "TTM Technologies, Inc."
    print_row "Kernel:" "Software Developer"
    print_row "IDE:" "Android Studio 2025.3.1, VSCode 1.106.3, antigravity 1.107.0"
    echo -e "${C_DOT}.${C_RESET}"
    print_row "Languages.Programming:" "Golang, Python, Rust, TypeScript, bash"
    print_row "Languages.Computer:" "HTML, CSS, JSON, TOML, YAML"
    print_row "Languages.Real:" "English, Malayalam"
    echo -e "${C_DOT}.${C_RESET}"
    print_row "Hobbies.Software:" "Web Apps, System Design, Linux, Automation"
    print_row "Hobbies.Hardware:" "Embedded Systems, Servers, AI"
    echo ""

    print_header "${C_DASH}-${C_RESET} ${C_TITLE}Contact" "- Contact"
    print_row "Email.Personal:" "devarajperayil327@gmail.com"
    print_row "Email.Personal:" "contact@devaraj.dev"
    print_row "Website:" "https://devaraj.dev"
    print_row "LinkedIn:" "devdevaraj"
    print_row "Youtube:" "bittobolt"
    echo ""

    # print_header "${C_DASH}-${C_RESET} ${C_TITLE}GitHub Stats" "- GitHub Stats"

    # Row 1 calculation
    # R1_COL1_PLAIN="Repos: 70 {Contributed: 133} | Stars:"
    # R1_VAL="342"
    # R1_PAD=$((MAX_WIDTH - ${#R1_COL1_PLAIN} - ${#R1_VAL} - 9))
    # printf -v r1_dots '%*s' "$R1_PAD" ""
    # r1_dots=${r1_dots// /.}

    # echo -e "${C_DOT}.${C_RESET} ${C_KEY}Repos:${C_RESET} ${C_DOT}....${C_RESET} ${C_VAL}95${C_RESET} ${C_KEY}{Contributed: 133}${C_RESET} ${C_TITLE}|${C_RESET} ${C_KEY}Stars:${C_RESET} ${C_DOT}${r1_dots}${C_RESET} ${C_VAL}${R1_VAL}${C_RESET}"

    # Row 2 calculation
    # R2_COL1_PLAIN="Commmits: 2,116 | Followers:"
    # R2_VAL="7"
    # R2_PAD=$((MAX_WIDTH - ${#R2_COL1_PLAIN} - ${#R2_VAL} - 22)) # Adjusted by 4 manually for spacing
    # printf -v r2_dots '%*s' "$R2_PAD" ""
    # r2_dots=${r2_dots// /.}
    # echo -e "${C_DOT}.${C_RESET} ${C_KEY}Commmits:${C_RESET} ${C_DOT}.................${C_RESET} ${C_VAL}2,116${C_RESET} ${C_TITLE}|${C_RESET} ${C_KEY}Followers:${C_RESET} ${C_DOT}${r2_dots}${C_RESET} ${C_VAL}${R2_VAL}${C_RESET}"

    # Row 3
    # R3_COL1_PLAIN="Lines of Code on GitHub:"
    # R3_VAL="446,276 ( 523,178++, 76,902-- )"
    # R3_PAD=$((MAX_WIDTH - ${#R3_COL1_PLAIN} - ${#R3_VAL} - 4))
    # printf -v r3_dots '%*s' "$R3_PAD" ""
    # r3_dots=${r3_dots// /.}
    # echo -e "${C_DOT}.${C_RESET} ${C_KEY}Lines of Code on GitHub:${C_RESET} ${C_DOT}${r3_dots}${C_RESET} ${C_VAL}446,276${C_RESET} ${C_TITLE}(${C_RESET} ${C_GREEN}523,178++${C_RESET}${C_TITLE},${C_RESET} ${C_RED}76,902--${C_RESET} ${C_TITLE})${C_RESET}"
}

mapfile -t ASCII_LINES < "$(dirname "$0")/me-ascii.txt"
mapfile -t PROFILE_LINES < <(generate_profile)

ASCII_WIDTH=52
max_lines=$(( ${#ASCII_LINES[@]} > ${#PROFILE_LINES[@]} ? ${#ASCII_LINES[@]} : ${#PROFILE_LINES[@]} ))

echo -e "\n\n"

for ((i=0; i<max_lines; i++)); do
    ascii_line="${ASCII_LINES[i]:-}"
    printf -v padded_ascii "%-${ASCII_WIDTH}s" "$ascii_line"
    profile_line="${PROFILE_LINES[i]:-}"
    echo -e "     ${padded_ascii}   ${profile_line}"
done

echo -e "\n\n"