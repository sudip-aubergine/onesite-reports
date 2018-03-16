RRBIN="${GOPATH}/src/rentroll/tmp/rentroll"

if [ ! -d ${RRBIN} ]; then
    echo "Rentroll has not been setup"
    exit 1
fi

ONESITELOAD="${RRBIN}/importers/onesite/onesiteload -noauth"
CSVLOAD="${RRBIN}/rrloadcsv -noauth"
BUD=ISO

# create new database, drop it if already exists
${RRBIN}/rrnewdb

# load business information first
${CSVLOAD} -b ./business.csv >./business.txt 2>&1

# generate reports for each dir which has no `report.txt` file
for dir in $(find . -maxdepth 1 -type d -name "[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]"); do
    REPORT_PATH="${dir}/report.txt"
    if [ ! -f ${REPORT_PATH} ]; then
        LOGFILE="${dir}/log"
        ONESITE_CSV="${dir}/onesite.csv"
        echo -n "Date/Time:    " >>${LOGFILE}
        date >> ${LOGFILE}
        echo "\nGenerating onesite report for ${ONESITE_CSV} ..." | tee -a ${LOGFILE}
        ${ONESITELOAD} -csv ${ONESITE_CSV} -bud ${BUD} >${REPORT_PATH} 2>&1
        echo "Report has been generated for ${ONESITE_CSV} at path ${REPORT_PATH}" | tee -a ${LOGFILE}
    fi
done

