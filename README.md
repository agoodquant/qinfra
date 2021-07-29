# qinfra

 Environment Setup
 ===========
To run this framework, you will need to install R

You also need to download the "binaries" of Q/KDB+ for corresponding environment in order to run the launch scripts.

To launch a Q process, execute w32/q.bat (or w32v35/q.bat), open a port by typing "\p 26041" (whatever port number you preferred)

To use https and wss, you will need to setup openssl on windows. Do the following (first check https://code.kx.com/wiki/Cookbook/SSL)
  1. Download openssl from https://slproweb.com/products/Win32OpenSSL.html (I have tested Win32 OpenSSL v1.0.2n Light)
  2. Append "C:\OpenSSL-Win32" and "C:\OpenSSL-Win32\bin" into the environment variable PATH
  3. Create the directory %userprofile%\certs (feel free to change the directory)
  4. Go to that directory and execute the following. You might encounter some problems while executing the followings. To avoid that, execute openssl.exe and execute commands below (start from 4.2) <br/>
    4.1 set RANDFILE=%userprofile%\certs\.rand<br/>
    4.2 openssl genrsa 2048 > ca-key.pem<br/>
    4.3 openssl >> <br/>
    4.4 req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem -extensions usr_cert -subj '/C=CA/ST=Ontario/L=Toronto/O=dummy/CN=dummy.com'<br/>
    4.5 req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem -extensions usr_cert -subj '/C=CA/ST=Ontario/L=Toronto/CN=dummy.com'<br/>
    4.6 rsa -in server-key.pem -out server-key.pem<br/>
    4.7 x509 -req -in server-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-crt.pem -extensions usr_cert<br/>
    4.8 req -newkey rsa:2048 -days 3600  -nodes -keyout client-key.pem -out client-req.pem -extensions usr_cert -subj '/C=CA/ST=Ontario/L=Toronto/O=dummy/CN=dummy.com'<br/>
    4.9 rsa -in client-key.pem -out client-key.pem<br/>
    4.10 x509 -req -in client-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out client-crt.pem -extensions usr_cert<br/>
   5. set the following two environment variables before executing q.exe<br/>
    5.1 set SSL_CERT_FILE=%userprofile%\certs\server-crt.pem<br/>
    5.2 set SSL_KEY_FILE=%userprofile%\certs\server-key.pem<br/>
    5.3 to execute q in ssl mode, in command line: q -E 1<br/>
    5.4 alternatively, you can edit and execute q_ssl.bat<br/>

On Linux, simply skip step 1 & 2. And replace %userprofile% to $HOME whereever applicable

 Q Depends
 ===========
.qinfra.cleanDep[];<br/>
.qinfra.loadDep["env";"Q:/qr/env"];<br/>
.qinfra.loadDep["quant";"Q:/qr/quant"];<br/>
.qinfra.listDep[]

 Q Load
 ===========
.qinfra.load["env"];<br/>
.qinfra.load["thirdparty"];<br/>
.qinfra.load["quant"];<br/>
.qinfra.load["util"];<br/>
.qinfra.include["quant"; "random.q"];<br/>
.qinfra.reload[];<br/>
.qinfra.listModule[]


 Tools Setup
 ===========

 1. [Sublime](https://www.sublimetext.com/)
 2. [Sublime Q](https://github.com/komsit37/sublime-q)
 3. [Bare Tail](https://www.baremetalsoft.com/baretail/)
 4. [Studio for KDB+](https://github.com/CharlesSkelton/studio/blob/master/releases/studio.zip)
 5. [Qstudio for research](http://www.timestored.com/qstudio/)

 Licence
 ===========
 
 [MIT](https://github.com/agoodquant/qinfra/blob/master/LICENSE)
