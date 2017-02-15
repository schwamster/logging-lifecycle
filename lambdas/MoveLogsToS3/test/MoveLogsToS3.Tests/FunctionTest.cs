using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Xunit;
using Amazon.Lambda.Core;
using Amazon.Lambda.TestUtilities;
using Amazon.Lambda.KinesisEvents;

using MoveLogsToS3;
using System.IO;
using System.Text;

namespace MoveLogsToS3.Tests
{
    public class FunctionTest
    {
        [Fact]
        public void TestToUpperFunction()
        {
            //var testEvent = File.ReadAllText("event.json");
            var testEvent = @"{
    ""Records"": [
        {
                ""kinesis"": {
                    ""kinesisSchemaVersion"": ""1.0"",
                ""partitionKey"": ""e7395803c596b7acc0f2842aefdab967"",
                ""sequenceNumber"": ""49570470725142152796058858090552619191482435850492444674"",
                ""data"": ""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"",
                ""approximateArrivalTimestamp"": 1487191893.306
                },
            ""eventSource"": ""aws:kinesis"",
            ""eventVersion"": ""1.0"",
            ""eventID"": ""shardId-000000000000:49570470725142152796058858090552619191482435850492444674"",
            ""eventName"": ""aws:kinesis:record"",
            ""invokeIdentityArn"": ""arn:aws:iam::394296847239:role/iam_for_lambda"",
            ""awsRegion"": ""eu-central-1"",
            ""eventSourceARN"": ""arn:aws:kinesis:eu-central-1:394296847239:stream/terraform-kinesis-log""
        }
    ]
}";
          

            var serializer = new Amazon.Lambda.Serialization.Json.JsonSerializer();
            Stream json = new MemoryStream(Encoding.UTF8.GetBytes(testEvent));
            var kinesisEvent = serializer.Deserialize<KinesisEvent>(json);

            var function = new Function();
            var context = new TestLambdaContext();
            var upperCase = function.FunctionHandler(kinesisEvent, context);

            Assert.Equal("OK", upperCase);
        }
    }
}
