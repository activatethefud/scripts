#!/bin/bash

wget -O new http://poincare.matf.bg.ac.rs/~kmiljan/raspored/sve/form_002.html

difference=$(diff old new | wc -l)

if [ $difference -ge 1 ]; then
	echo "Sending mail..."
	echo -e "Nastale su promene u rasporedu:\nhttp://poincare.matf.bg.ac.rs/~kmiljan/raspored/sve/form_002.html" | mail -s "Raspored promenjen" nikolasutic1@gmail.com
	cp new old
fi
