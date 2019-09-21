using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ServiceFabric.Services.Runtime;

namespace ECommerce.ProductCatalog
{
   internal static class Program
   {
      /// <summary>
      /// This is the entry point of the service host process.
      /// </summary>
      private static void Main()
      {
         try
         {
                // The ServiceManifest.XML file defines one or more service type names.
                // Registering a service maps a service type name to a .NET type.
                // When Service Fabric creates an instance of this service type,

                // Teling that created service and how create instances for this reliable services

                ServiceRuntime.RegisterServiceAsync("ECommerce.ProductCatalogType",
                context => new ProductCatalog(context)).GetAwaiter().GetResult();

                // log reliable service has start
            ServiceEventSource.Current.ServiceTypeRegistered(
               Process.GetCurrentProcess().Id,
               typeof(ProductCatalog).Name);

            // Prevents this host process from terminating so services keep running. Sleep forever.
            Thread.Sleep(Timeout.Infinite);
         }
         catch(Exception e)
         {
            ServiceEventSource.Current.ServiceHostInitializationFailed(e.ToString());
            throw;
         }
      }
   }
}