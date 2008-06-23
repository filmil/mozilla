#!/bin/bash
echo "Patching Translate Toolkit quirks"

echo "reporterMenu.accessKey quirk"
INFILE=output/sr/extensions/reporter/chrome/reporterOverlay.dtd
TEMPFILE=output/sr/extensions/reporter/chrome/reporterOverlay.dtd.1
sed -e "s/reporterMenu.accesskey \"R\"/reporterMenu.accesskey\ \"П\"/" < $INFILE > $TEMPFILE
mv $TEMPFILE $INFILE
