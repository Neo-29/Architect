function endscript() {
    local -r end_time="$(date +%s)"
    local -r duration="$((${end_time} - ${1}))"

    echo -e "${DONE_IN} ${GREEN}${duration}${RESET} ${SECONDS}."
    echo -e "${DONE_IN} ${duration} ${SECONDS}." >>"${LOG_FILE}"

    read -rp "${USE_PASTEBIN} (${YES_MIN}/N) " response

    if [[ "${response^^}" == "${YES}" ]]; then
        echo -e "${UPLOADING_PASTEBIN}..."
        local -r url="$(curl -s -F 'file=@'"${LOG_FILE}" https://0x0.st)"
        echo -e "${UPLOADED} ${url}"
    fi

    read -rp "${GREEN}${FINISHED}${RESET}: ${PRESS} ${GREEN}${ENTER}${RESET} ${TO_RESTART} ${OR} ${GREEN}Ctrl+C${RESET} ${TO_CANCEL}."
    for i in {5..1}; do
        echo -ne "${GREEN}${RESTARTING_IN} ${i} ${SECONDS}...${RESET}\r"
        sleep 1
    done
    reboot
}
