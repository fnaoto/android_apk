```
keytool -J-Dkeystore.pkcs12.legacy -genkey -v -keystore legacy.keystore -keyalg RSA -validity 10950 -storepass android -alias androiddebugkey -dname "CN=Android Debug, O=Android, C=US"

keytool -J-Dkeystore.pkcs12.legacy -genkey -v -keystore new.keystore -keyalg RSA -validity 10950 -storepass android -alias androiddebugkey -dname "CN=Android Debug, O=Android, C=US"
```

```
# Create a certificate lineage
apksigner rotate --out legacy-to-new.lineage --old-signer --ks legacy.keystore --new-signer --ks new.keystore
# Sign an app file with a lineage
apksigner sign --lineage legacy-to-new.lineage --ks legacy.keystore --next-signer --ks new.keystore app-rotated.apk
```

```
apksigner sign --ks new.keystore app-new.apk
apksigner sign --ks legacy.keystore app-legacy.apk
```