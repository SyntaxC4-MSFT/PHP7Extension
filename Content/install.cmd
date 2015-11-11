## Download PHP7 x86 Runtime
cd Commands

curl -L -o PHP7x86.zip http://windows.php.net/downloads/qa/php-7.0.0RC6-nts-Win32-VC14-x86.zip
d:\7zip\7za x PHP7x86.zip -oPHP7x86

rm PHP7x86.zip

## Move ApplicationHost.xdt

cd ..
cp applicationHost.xdt.bak d:\home\site\applicationHost.xdt

## Create PHP.ini

cp php.ini-production php.ini

## Enable Impersonate and Disable FastCGI Logging

