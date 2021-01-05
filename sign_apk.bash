#/bin/env bash 

set -eux

APK=$1

# Create the key. This is the manual way.
# keytool -genkey -v -keystore "YELLOKEY" -alias "YELLOW SUBMARINE" -keyalg RSA -keysize 2048 -validity 10000
# But for a script we can do better
keytool -genkey -noprompt -v \
 -dname "CN=mqttserver.ibm.com, OU=ID, O=IBM, L=Hursley, S=Hants, C=GB" \
 -keystore "YELLOW" \
 -storepass "password" \
 -keypass "password" \
 -alias "YELLOW SUBMARINE" \
 -keyalg RSA \
 -keysize 2048 \
 -validity 1000

# Sign the jar. I could not find a way to automate this :(
echo "PASSWORD is 'password'"
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "YELLOW" $APK "YELLOW SUBMARINE" 

# delete the silly key we just created
rm "YELLOW"
