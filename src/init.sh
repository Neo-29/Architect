function header() {
    clear
    cat <<-EOF
-----------------------------------------------------------------------------------------------------------

       ${PURPLE}%%%%%%%%%%${RESET}  ${GREEN}*********${RESET}            
       ${PURPLE}%%%${RESET}                 ${GREEN}******${RESET}       
       ${PURPLE}%%%${RESET}                     ${GREEN}***${RESET}      ${SCRIPT_DESC}
       ${PURPLE}%%%${RESET}                     ${GREEN}***${RESET}      
       ${PURPLE}%%%${RESET}                     ${GREEN}***${RESET}      GitHub : https://github.com/Cardiacman13/Architect
       ${PURPLE}%%%${RESET}                     ${GREEN}***${RESET}      
       ${PURPLE}%%%${RESET}                     ${GREEN}***${RESET}      ${BY} https://github.com/Cardiacman13
        ${PURPLE}%%%%%%${RESET}                 ${GREEN}***${RESET}      ${AND} https://github.com/wmemcpy
             ${PURPLE}%%%%%%%%${RESET}  ${GREEN}***********${RESET}     

-----------------------------------------------------------------------------------------------------------
EOF

    sleep 1
    printf "%b" "${RED}${CHANGES_WARNING}${RESET}\n"
    printf "%b" "${DURATION_WARNING}\n${PRESS} ${GREEN}${ENTER}${RESET} ${TO_CONTINUE}, ${OR} ${GREEN}Ctrl+C${RESET} ${TO_CANCEL}."

    read -rp "" choice
    [[ -n $choice ]] && exit 0
}

function init_log() {
    if [[ -f "${LOG_FILE}" ]]; then
        rm -f "${LOG_FILE}"
    fi

    touch "${LOG_FILE}"
    echo -e "Commit hash: $(git rev-parse HEAD)" >>"${LOG_FILE}"
    echo -e "Log file: ${LOGFILE}\n" >>"${LOG_FILE}"
}

function language_conf() {
    LANG_CODE=$(echo $LANG | cut -d '_' -f 1)
    
    DEFAULT_LANG_FILE=lang/source/en.lang.sh
    LANG_FILE=lang/source/${LANG_CODE}.lang.sh
    
    if [[ -f "${LANG_FILE}" ]]; then
        source $LANG_FILE
    else
        source $DEFAULT_LANG_FILE
    fi
}