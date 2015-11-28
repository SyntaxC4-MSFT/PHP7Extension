:: Download PHP7 x86 Runtime

IF NOT EXIST Commands (
  mkdir Commands
)

cd Commands

IF EXIST PHP7x86 (
 rm -rf PHP7x86
)

curl -L -o PHP7x86.zip http://windows.php.net/downloads/qa/php-7.0.0RC8-nts-Win32-VC14-x86.zip
d:\7zip\7za x PHP7x86.zip -oPHP7x86

:: Create PHP.ini
cd PHP7x86

sed -e 's/;fastcgi.impersonate = 1/fastcgi.impersonate = 1/g' -e 's/;fastcgi.logging = 0/fastcgi.logging = 0/g' php.ini-production > php.ini
echo extension_dir=ext >> php.ini

:: WinCache PHP7 Binary Drop

cd ext

IF NOT EXIST php_wincache.dll (
  curl -L -O https://github.com/SyntaxC4-MSFT/PHP7Extension/releases/download/v0.7.0/php_wincache.dll
)
  
:: WinCache PHP7 php.ini updates

cd ..
echo extension=php_wincache.dll >> php.ini

:: Move ApplicationHost.xdt

cd ..\..
cp applicationHost.xdt d:\home\site\applicationHost.xdt
mv applicationHost.xdt applicationHost.xdt.bak

:: Clean up

rm -rf PHP7x86.zip
