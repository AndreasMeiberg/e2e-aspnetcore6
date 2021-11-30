using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.AspNetCore.Mvc.Testing;  // from: https://www.nuget.org/packages/Microsoft.AspNetCore.Mvc.Testing

namespace aspnet_core_sample.UnitTests
{
    [TestClass]
    public class SampleUnitTests
    {
        private readonly WebApplicationFactory<Pages.IndexModel> _factory;

        public SampleUnitTests()
        {
            _factory = new WebApplicationFactory<Pages.IndexModel>();
        }

        [TestMethod]
        public async Task IndexPageReturnSuccessAndCorrectContentType()
        {
            // Arrange
            var client = _factory.CreateClient();

            // Act
            var response = await client.GetAsync("/");

            // Assert
            response.EnsureSuccessStatusCode(); // Status Code 200-299
            Assert.AreEqual("text/html; charset=utf-8", response.Content.Headers.ContentType?.ToString());
        }
    }
}