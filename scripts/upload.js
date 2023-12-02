import { PutObjectCommand  } from "@aws-sdk/client-s3";
import { s3Client } from "./s3Client.js";
import { createBucket } from "./createBucket.js";
import fs from 'fs'

const params = {
  Bucket: "terraform-tfstate-sync",
};

const result = {
  put: [],
}

const run = async () => {
  const bucketResult = await createBucket(params)
  console.log({
    type: 'bucketResult',
    response: bucketResult,
  })
  if (!bucketResult) {
    process.exit(5)
  }

  // Create an object and upload it to the Amazon S3 bucket.
  try {
    const list = [
      {
        Key: "terraform.tfvars",
        Body: fs.readFileSync('../terraform/terraform.tfstate', 'utf8')
      },
      {
        Key: "terraform.tfvars.backup",
        Body: fs.readFileSync('../terraform/terraform.tfstate.backup', 'utf8')
      },
    ];

    for (const fileObj of list) {
      const response = await s3Client.send(new PutObjectCommand({
        ...params,
        ...fileObj,
      }));

      result.put.push(response.$metadata.httpStatusCode)
    }

    console.log(result);
  } catch (err) {
    console.error("Error", err);
    process.exit(1)
  }
};

run();
