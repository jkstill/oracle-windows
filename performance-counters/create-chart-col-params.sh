#!/usr/bin/env bash


# generate dynachart.pl commands
# then just remove char-cols that are not needed


chartScriptName='perf-counter-charts.sh'

banner () {
	echo
	echo '########################################################'
	echo "## $@"
	echo '########################################################'
	echo
}

xlDir='xlsx'
mkdir -p $xlDir

for csvFile in csv-new/*.csv
do

	csvBaseFile=$(basename $csvFile)

	xlFile="$xlDir/"$(echo $csvBaseFile | cut -f1 -d\. )".xlsx"
	
		
	banner "csv: $csvFile xlsx: $xlFile"

	hdrLine=$(head -1 $csvFile)
	#echo "hdr: $hdrLine"

	echo "dynachart.pl --spreadsheet-file $xlFile \\" 
	echo "  --auto-filter-enabled \\"

	while read -d, colname
	do
		[[ $colname == 'timestamp' ]] && { continue; }
		echo "  --chart-cols '$colname' \\"
	done < <( echo "$hdrLine")
	echo " -- \\"

	echo " < $csvFile "
	echo 

done | tee $chartScriptName

chmod u+x $chartScriptName

cat <<EOF

The script $chartScriptName can be edited to remove columns that you do not want to be charted

This script uses dynachart.pl - details found at https://github.com/jkstill/dynachart

EOF


