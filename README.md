# camel-k-transformations
Camelを使って固定長ファイルからJson形式に変更するデモ。

データ投入はS3のバケットにアップロードし、ファイル検知してJSONに変換しKafkaに連携する。

## 必須コンフィグマップ
- Name: s3-config
- Key: parser.pzmap.xml
- Data: parser.pzmap.xmlの内容をコピーする
