var imageStore = new FS.Store.S3("images", {
  region: "us-west-2", //optional in most cases
  accessKeyId: "AKIAJXKF66DARFZ4TOWA", //required if environment variables are not set
  secretAccessKey: "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", //required if environment variables are not set
  bucket: "hackathon-re-quest", //required
  // ACL: "myValue", //optional, default is 'private', but you can allow public or secure access routed through your app URL
  folder: "uploads", //optional, which folder (key prefix) in the bucket to use
  // The rest are generic store options supported by all storage adapters
  // transformWrite: myTransformWriteFunction, //optional
  // transformRead: myTransformReadFunction, //optional
  // maxTries: 1 //optional, default 5
});

Images = new FS.Collection("images", {
  stores: [imageStore]
});