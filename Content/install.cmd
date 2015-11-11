:: Download PHP7 x86 Runtime

mkdir Commands
cd Commands

curl -L -o PHP7x86.zip http://windows.php.net/downloads/qa/php-7.0.0RC6-nts-Win32-VC14-x86.zip
d:\7zip\7za x PHP7x86.zip -oPHP7x86

:: Create PHP.ini

cd PHP7x86

sed -e 's/;fastcgi.impersonate = 1/fastcgi.impersonate = 1/g' -e 's/;fastcgi.logging = 0/fastcgi.logging = 0/g' php.ini-production > php.ini

:: Move ApplicationHost.xdt

cd ..\..
cp applicationHost.xdt d:\home\site\applicationHost.xdt
mv applicationHost.xdt applicationHost.xdt.bak

:: Clean up

rm -rf PHP7x86.zip
