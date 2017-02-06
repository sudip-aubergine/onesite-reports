RRBIN="/home/sudip/go-work/src/rentroll/tmp/rentroll"
ONESITELOAD="${RRBIN}/importers/onesite/onesiteload"
CSVLOAD="${RRBIN}/rrloadcsv"
BUD=ISO

${CSVLOAD} -b ./business.csv >./business.txt 2>&1

for f in */; do
    REPORT_PATH="./${f}report.txt"
    if [ ! -f ${REPORT_PATH} ]; then
        LOGFILE="./${f}log"
        ONESITE_CSV="./${f}onesite.csv"
        echo -n "Date/Time:    " >>${LOGFILE}
        date >> ${LOGFILE}
        echo "\nGenerating onesite report for ${ONESITE_CSV} ..." | tee -a ${LOGFILE}
        ${ONESITELOAD} -csv ${ONESITE_CSV} -bud ${BUD} >${REPORT_PATH} 2>&1
        echo "Report has been generated for ${ONESITE_CSV} at path ${REPORT_PATH}" | tee -a ${LOGFILE}
    fi
done

