import { GetObjectCommand  } from "@aws-sdk/client-s3";
import { s3Client } from "./s3Client.js";
import { createBucket } from "./createBucket.js";
import fs from 'fs'

const params = {
  Bucket: "terraform-tfstate-sync",
};

const result = {
  get: [],
}

const streamToString = (stream) =>
  new Promise((resolve, reject) => {
    const chunks = []
    stream.on('data', (chunk) => chunks.push(chunk))
    stream.on('error', reject)
    stream.on('end', () => resolve(Buffer.concat(chunks).toString('utf8')))
  })

const run = async () => {
  const bucketResult = await createBucket(params)
  console.log(bucketResult)

  // Create an object and upload it to the Amazon S3 bucket.
  try {
    const list = [
      {
        Key: "terraform.tfvars",
        downloadPath: '../terraform/terraform.tfstate',
      },
      {
        Key: "terraform.tfvars.backup",
        downloadPath: '../terraform/terraform.tfstate.backup',
      },
    ];

    for (const fileObj of list) {
      const response = await s3Client.send(new GetObjectCommand({
        ...params,
        Key: fileObj.Key,
      }));

      const str = await streamToString(response.Body)
      fs.writeFileSync(fileObj.downloadPath, str);

      result.get.push(fileObj.downloadPath)
    }

    console.log(result);
  } catch (err) {
    console.error("Error", err);
  }
};

run();
