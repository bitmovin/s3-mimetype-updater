# s3-mimetype-updater

## Usage

|Usage|./s3-mimetype-updater.sh S3URI accesskey secretkey|
|-----|--------------------------------------------------|
|**S3URI**|URI of your S3 bucket to recursively fix the MIME types in (must start with s3://)|
|**accesskey**|S3 access key of your user|
|**secretkey**|S3 secret key of your user|

## Preconditions

* Please make sure that you have a recent version of s3cmd installed (must support modify).
* Please make sure that your user has "Edit Permissions" rights on the affected files.



