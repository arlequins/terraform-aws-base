import { S3Client } from "@aws-sdk/client-s3";
import {fromIni} from "@aws-sdk/credential-providers";

const REGION = "ap-northeast-1";
const profile = process.env.PROFILE_NAME

const s3Client = new S3Client({
  region: REGION,
  credentials: fromIni({profile})
 });

export { s3Client, profile };
