import { CreateBucketCommand, HeadBucketCommand } from "@aws-sdk/client-s3";
import { s3Client, profile } from "./s3Client.js";

const createBucket = async (params) => {
  const result = {
    head: {
      result: -1,
    },
    create: {
      result: -1,
    }
  }

  // Head an Amazon S3 bucket.
  try {
    const response = await s3Client.send(new HeadBucketCommand({
      Bucket: params.Bucket,
    }));

    result.head.result = response.$metadata.httpStatusCode
  } catch (err) {
    const httpStatusCode = err.$response.statusCode
    result.head.result = httpStatusCode
  }

  if (result.head.result === 403) {
    console.error({reaspon: 'no auth',profile})
    return
  }

  if (result.head.result !== 200) {
    // Create an Amazon S3 bucket.
    try {
      const data = await s3Client.send(
        new CreateBucketCommand({
          Bucket: params.Bucket,
          ACL: "private",
        })
      );
      console.log(data);
      console.log("Successfully created a bucket called ", data.Location);
      result.create.result = 200
    } catch (err) {
      console.error("Error", err);
    }
  }

  return result
};

export {createBucket}
