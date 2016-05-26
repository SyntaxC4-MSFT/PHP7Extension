:: Download PHP7 x86 Runtime

IF NOT EXIST Commands (
  mkdir Commands
)

cd Commands

IF EXIST PHP7x86 (
 rm -rf PHP7x86
)

IF EXIST SQLSVR (
    rm -rf SQLSVR
)

IF EXIST REDIS (
    rm -rf REDIS
)

curl -L -o PHP7x86.zip http://windows.php.net/downloads/releases/php-7.0.7-nts-Win32-VC14-x86.zip
start /wait d:\7zip\7za.exe x PHP7x86.zip -oPHP7x86

curl -L -o SQLSVR.zip https://github.com/Azure/msphpsql/releases/download/v4.0.2/x86.zip
start /wait d:\7zip\7za.exe x SQLSVR.zip -oSQLSVR

curl -L -o REDIS.zip http://windows.php.net/downloads/pecl/snaps/redis/20160319/php_redis-20160319-nts-vc14-x86.zip
start /wait d:\7zip\7za.exe x REDIS.zip -oREDIS

:: Create PHP.ini
cd PHP7x86

sed -e 's/;fastcgi.impersonate = 1/fastcgi.impersonate = 1/g' -e 's/;fastcgi.logging = 0/fastcgi.logging = 0/g' php.ini-production > php.ini
echo extension_dir=ext >> php.ini

:: WinCache PHP7 Binary Drop

cd ext
curl -L -O https://github.com/SyntaxC4-MSFT/PHP7Extension/releases/download/0.1.7/php_wincache.dll

:: Including the SQL Server Technical Preview Drivers x86 only.
cp d:\home\SiteExtensions\PHP7Extension\Commands\SQLSVR\x86\php_sqlsrv_7_nts.dll .\php_sqlsrv.dll

:: Including the REDIS PHP 7 Driver Preview
cp d:\home\SiteExtensions\PHP7Extension\Commands\REDIS\php_redis.dll .\php_redis.dll
  
:: WinCache PHP7 php.ini updates

cd ..
echo extension=php_wincache.dll >> php.ini
echo extension=php_sqlsrv.dll >> php.ini
echo extension=php_redis.dll >> php.ini

:: Other Extensions 
echo extension=php_mysqli.dll >> php.ini
echo extension=php_mbstring.dll >> php.ini
echo extension=php_gd2.dll >> php.ini
echo extension=php_gettext.dll >> php.ini
echo extension=php_curl.dll >> php.ini
echo extension=php_exif.dll >> php.ini
echo extension=php_xmlrpc.dll >> php.ini
echo extension=php_openssl.dll >> php.ini
echo extension=php_soap.dll >> php.ini
echo extension=php_pdo_mysql.dll >> php.ini
echo extension=php_pdo_sqlite.dll >> php.ini
echo extension=php_imap.dll >> php.ini
echo extension=php_tidy.dll >> php.ini
echo extension=php_com_dotnet.dll >> php.ini
echo extension=php_intl.dll >> php.ini
echo extension=php_fileinfo.dll >> php.ini
echo zend_extension=php_opcache.dll >> php.ini

:: Other PHP.ini settings

echo error_log=${HOME}\LogFiles\php_errors.log >> php.ini
echo upload_tmp_dir=${TEMP} >> php.ini
echo session.save_path=${TEMP} >> php.ini
echo wincache.filemapdir=${TEMP} >> php.ini
echo short_open_tag=On

:: Move ApplicationHost.xdt

cd ..\..
cp applicationHost.xdt %HOME%\site\applicationHost.xdt
mv applicationHost.xdt applicationHost.xdt.bak

:: Clean up

rm -rf PHP7x86.zip
