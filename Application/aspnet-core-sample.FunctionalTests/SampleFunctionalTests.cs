using System;
using System.Threading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace aspnet_core_sample.FunctionalTests
{
    [TestClass]
    public class SampleFunctionalTests
    {
        private static TestContext testContext;
        private WebDriver driver;

        [ClassInitialize]
        public static void Initialize(TestContext testContext)
        {
            SampleFunctionalTests.testContext = testContext;
        }

        [TestInitialize]
        public void TestInit()
        {
            driver = GetChromeDriver();
            driver.Manage().Timeouts().PageLoad = TimeSpan.FromSeconds(120);
        }

        [TestCleanup]
        public void TestClean()
        {
            if (testContext.CurrentTestOutcome != UnitTestOutcome.Passed)
            {
                TakeScreenshot(driver, @"Test-Failed.png");
            }

            driver.Quit();
        }

        [TestMethod]
        [Timeout(5 * 60 * 1000)] // 5 minutes
        [TestCategory("UI")]
        public void SampleFunctionalTest1()
        {
            var webAppUrl = testContext.Properties["webAppUrl"].ToString();
            string expectedTitle = "Home page - ASP.NET Core Sample";

            var startTimestamp = DateTime.Now.Millisecond;
            var endTimestamp = startTimestamp + 2 * 60 * 1000; // 2 minutes

            while (true)
            {
                try
                {
                    ConfigureTimeouts(driver);

                    testContext.WriteLine("Navigating to URL: " + webAppUrl);
                    driver.Navigate().GoToUrl(webAppUrl);
                    testContext.WriteLine($"Page title is: {driver.Title} ({driver.Title.Length} chars)");
                    Assert.AreEqual(expectedTitle, driver.Title, $"Expected title to be '{expectedTitle}'");

                    TakeScreenshot(driver, @"Screenshot.png");

                    break;
                }
                catch (Exception ex)
                {
                    var currentTimestamp = DateTime.Now.Millisecond;
                    if (currentTimestamp > endTimestamp)
                    {
                        throw;
                    }
                    testContext.WriteLine($"Error occured ({ex.Message}). Will retry in 5 seconds.");
                    Thread.Sleep(5000);
                }
            }
        }

        private static WebDriver GetChromeDriver()
        {
            var path = Environment.GetEnvironmentVariable("ChromeWebDriver");
            var options = new ChromeOptions();
            options.AddArguments("--no-sandbox");

            if (!string.IsNullOrWhiteSpace(path))
            {
                return new ChromeDriver(path, options, TimeSpan.FromSeconds(300));
            }
            else
            {
                return new ChromeDriver(options);
            }
        }

        private static void ConfigureTimeouts(WebDriver driver)
        {
            driver.Manage().Timeouts().PageLoad = TimeSpan.FromSeconds(60);
            driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(5);
        }

        private static void TakeScreenshot(WebDriver driver, string filename)
        {
            ((OpenQA.Selenium.ITakesScreenshot)driver).GetScreenshot().SaveAsFile(filename, OpenQA.Selenium.ScreenshotImageFormat.Png);

            testContext.AddResultFile(@filename);
        }
    }
}
