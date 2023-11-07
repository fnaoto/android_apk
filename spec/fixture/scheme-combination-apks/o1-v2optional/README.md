## unsigned

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
DOES NOT VERIFY
ERROR: Missing META-INF/MANIFEST.MF
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v1-and-v2-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v1-and-v2

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v1-and-v3-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #1 certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #1 certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #1 public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #1 public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v1-and-v3.1-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): true
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key algorithm: RSA
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key size (bits): 2048
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Signer (minSdkVersion=24, maxSdkVersion=32) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer (minSdkVersion=24, maxSdkVersion=32) certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer (minSdkVersion=24, maxSdkVersion=32) key algorithm: RSA
Signer (minSdkVersion=24, maxSdkVersion=32) key size (bits): 2048
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer (minSdkVersion=24, maxSdkVersion=32) public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v1-and-v3.1

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): true
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key algorithm: RSA
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key size (bits): 2048
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Signer (minSdkVersion=24, maxSdkVersion=32) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer (minSdkVersion=24, maxSdkVersion=32) certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer (minSdkVersion=24, maxSdkVersion=32) key algorithm: RSA
Signer (minSdkVersion=24, maxSdkVersion=32) key size (bits): 2048
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer (minSdkVersion=24, maxSdkVersion=32) public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v1-and-v3

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #1 certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #1 certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #1 public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #1 public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v1-only-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): true
Verified using v2 scheme (APK Signature Scheme v2): false
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v1-only

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): true
Verified using v2 scheme (APK Signature Scheme v2): false
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v2-only-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v2-only

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
</pre>

**apksigner lineage**

<pre>
The provided APK does not contain a valid V3 nor V3.1 signature block.
</pre>

## v3-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #1 certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #1 certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #1 public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #1 public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v3.1-with-source-stamp

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): true
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: true
Number of signers: 1
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key algorithm: RSA
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key size (bits): 2048
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Signer (minSdkVersion=24, maxSdkVersion=32) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer (minSdkVersion=24, maxSdkVersion=32) certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer (minSdkVersion=24, maxSdkVersion=32) key algorithm: RSA
Signer (minSdkVersion=24, maxSdkVersion=32) key size (bits): 2048
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer (minSdkVersion=24, maxSdkVersion=32) public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Source Stamp Signer certificate DN: CN=Android Debug, O=Android, C=US
Source Stamp Signer certificate SHA-256 digest: 0b63eaba2f40e60eeb72805a530aa510a43b428673838313fdcf411fc2e12219
Source Stamp Signer certificate SHA-1 digest: 318d960dc6459a3773f61fe107f9f1df018b8988
Source Stamp Signer certificate MD5 digest: 9640524171e063414f4fb9d8295683b6
Source Stamp Signer key algorithm: RSA
Source Stamp Signer key size (bits): 2048
Source Stamp Signer public key SHA-256 digest: 7552c7f4e109ae1f7cd9df5159e32717d8bf6ad183f8e8507ca4d5205548a394
Source Stamp Signer public key SHA-1 digest: 596a235302bea6411009b757ff2bde3dd2221683
Source Stamp Signer public key MD5 digest: c00d1f26992faef2c061fa428c6fdfd5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v3.1

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): true
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer (minSdkVersion=33, maxSdkVersion=2147483647) certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key algorithm: RSA
Signer (minSdkVersion=33, maxSdkVersion=2147483647) key size (bits): 2048
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer (minSdkVersion=33, maxSdkVersion=2147483647) public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Signer (minSdkVersion=24, maxSdkVersion=32) certificate DN: CN=Android Debug, O=Android, C=US
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer (minSdkVersion=24, maxSdkVersion=32) certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer (minSdkVersion=24, maxSdkVersion=32) certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer (minSdkVersion=24, maxSdkVersion=32) key algorithm: RSA
Signer (minSdkVersion=24, maxSdkVersion=32) key size (bits): 2048
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer (minSdkVersion=24, maxSdkVersion=32) public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer (minSdkVersion=24, maxSdkVersion=32) public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

## v3

<pre>
package: name='com.deploygate.playground.signature.o1.v2optional' versionCode='1' versionName='1.0-o1-v2optional' platformBuildVersionName='13' platformBuildVersionCode='33' compileSdkVersion='33' compileSdkVersionCodename='13'
sdkVersion:'27'
targetSdkVersion:'29'
</pre>

**apksigner verify**

<pre>
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): true
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
Signer #1 certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #1 certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #1 certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #1 key algorithm: RSA
Signer #1 key size (bits): 2048
Signer #1 public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #1 public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #1 public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
</pre>

**apksigner lineage**

<pre>
Signer #1 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #1 in lineage certificate SHA-256 digest: 4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f
Signer #1 in lineage certificate SHA-1 digest: eb6cbb57f091e97d614cdc773aa2efc66a39a818
Signer #1 in lineage certificate MD5 digest: 1406a3ae028053ad27778af3efe6fbd8
Signer #1 in lineage key algorithm: RSA
Signer #1 in lineage key size (bits): 2048
Signer #1 in lineage public key SHA-256 digest: 2457e91da4008c890e8a1e218c0ece23dfe520b92f3a59fdafabd21bcae3139d
Signer #1 in lineage public key SHA-1 digest: 38257f19b1970883305895bb1b97a5180dff9af0
Signer #1 in lineage public key MD5 digest: 2a0ddfab1d28713e086e9c530f19d0f5
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
Signer #2 in lineage certificate DN: CN=Android Debug, O=Android, C=US
Signer #2 in lineage certificate SHA-256 digest: 4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc
Signer #2 in lineage certificate SHA-1 digest: e9d0dd023bdab7fae9479d1ecbb3275e0fccac20
Signer #2 in lineage certificate MD5 digest: 4b85af08b8186094d7b90b992b121e8d
Signer #2 in lineage key algorithm: RSA
Signer #2 in lineage key size (bits): 2048
Signer #2 in lineage public key SHA-256 digest: e65191a77ba34af476b08941a6ad71efd1f1da2385329edb06436e4d52737a82
Signer #2 in lineage public key SHA-1 digest: 7b6ef950aab3e138d6ec519d6aeef672c27641e5
Signer #2 in lineage public key MD5 digest: 6c9e8d35201330cc34b3792297b98cca
Has installed data capability: true
Has shared UID capability    : true
Has permission capability    : true
Has rollback capability      : false
Has auth capability          : true
</pre>

