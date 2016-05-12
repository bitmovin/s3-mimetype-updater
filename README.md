# s3-mimetype-updater

## Usage

|Usage|./s3-mimetype-updater.sh S3URI accesskey secretkey|
|-----|--------------------------------------------------|
|**S3URI**|URI of your S3 bucket to recursively fix the MIME types in (must start with s3://)|
|**accesskey**|S3 access key of your user|
|**secretkey**|S3 secret key of your user|

## Preconditions

* Please make sure that you have s3cmd version >= 1.5.0 installed. Latest version: 1.6.1. Can be downloaded from: http://s3tools.org/download
* Please make sure that your user has 's3:PutObjectAcl' permission on the affected files.



