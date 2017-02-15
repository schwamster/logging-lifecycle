using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Amazon.Lambda.Core;
using Amazon.Lambda.KinesisEvents;
using Amazon.Lambda.Serialization;
using Amazon.Lambda.Serialization.Json;
using System.IO;
using System.IO.Compression;
using Amazon.S3;
using Amazon;
using Amazon.S3.Model;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializerAttribute(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace MoveLogsToS3
{
    public class Function
    {
        private readonly string destinationBucket;
        public Function()
        {
            destinationBucket = Environment.GetEnvironmentVariable("bucket");
            Console.WriteLine($"Initialized MoveLogsToS3 with destination bucket '{destinationBucket}'");
        }

        /// <summary>
        /// A simple function that takes a string and does a ToUpper
        /// </summary>
        /// <param name="input"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public string FunctionHandler(KinesisEvent kinesisEvent, ILambdaContext context)
        {
            HandleKinesisRecord(kinesisEvent);
            return "OK";
        }

        public void HandleKinesisRecord(KinesisEvent kinesisEvent)
        {
            Console.WriteLine($"Beginning to process {kinesisEvent.Records.Count} records...");
            var logs = "";
            foreach (var record in kinesisEvent.Records)
            {
                Console.WriteLine($"Event ID: {record.EventId}");
                Console.WriteLine($"Event Name: {record.EventName}");
                string recordData = GetRecordContents(record.Kinesis);
                logs = logs + recordData;
                Console.WriteLine($"Record Data:");
                Console.WriteLine(recordData);
            }
            //todo: region needs to be read from env vars as well
            try
            {
                using (var client = new AmazonS3Client())
                {
                    var key = DateTime.UtcNow.ToString("yyyyMMddHHmmssfff");
                    Console.WriteLine("key {0}", key);
                    PutObjectRequest request = new PutObjectRequest()
                    {
                        ContentBody = logs,
                        BucketName = this.destinationBucket,
                        Key = $"{key}"
                    };
                    Console.WriteLine("Created object for bucket");
                    PutObjectResponse response = client.PutObjectAsync(request).Result;
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error while writting to bucket: {0}", ex);
            }


            Console.WriteLine("Stream processing complete.");
        }

        private string GetRecordContents(KinesisEvent.Record streamRecord)
        {
            return CompressionHelper.Unzip(streamRecord.Data.ToArray());
        }
    }
}
