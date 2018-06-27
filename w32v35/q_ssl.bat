set SSL_CERT_FILE=%userprofile%\certs\server-crt.pem
set SSL_KEY_FILE=%userprofile%\certs\server-key.pem
set SSL_VERIFY_SERVER=FALSE
set QHOME=%~dp0
set initScript=%QHOME%..\qinfra.q

"%QHOME%q" %initScript% %*