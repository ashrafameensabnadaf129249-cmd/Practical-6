using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ProductCatalog.Models
{
    public class Product
    {
        public int ProductId { get; set; }

        [Required]
        public string ProductName { get; set; }

        [Required]
        public string Category { get; set; }

        [Range(0, double.MaxValue)]
        public decimal Price { get; set; }

        public string Description { get; set; }
    }
}

namespace ProductCatalog.Controllers
{
    public class ProductController : Controller
    {
        private static List<ProductCatalog.Models.Product> products =
            new List<ProductCatalog.Models.Product>()
            {
                new ProductCatalog.Models.Product()
                {
                    ProductId = 1,
                    ProductName = "Laptop",
                    Category = "Electronics",
                    Price = 55000,
                    Description = "High performance laptop"
                },
                new ProductCatalog.Models.Product()
                {
                    ProductId = 2,
                    ProductName = "Smartphone",
                    Category = "Electronics",
                    Price = 25000,
                    Description = "Latest Android smartphone"
                },
                new ProductCatalog.Models.Product()
                {
                    ProductId = 3,
                    ProductName = "Headphones",
                    Category = "Accessories",
                    Price = 2500,
                    Description = "Wireless headphones"
                },
                new ProductCatalog.Models.Product()
                {
                    ProductId = 4,
                    ProductName = "Keyboard",
                    Category = "Accessories",
                    Price = 1500,
                    Description = "Mechanical keyboard"
                }
            };

        public ActionResult Index()
        {
            return View(products);
        }

        public ActionResult Details(int id)
        {
            var product = products.FirstOrDefault(
                p => p.ProductId == id);

            if (product == null)
                return HttpNotFound();

            return View(product);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ProductCatalog.Models.Product product)
        {
            if (ModelState.IsValid)
            {
                product.ProductId = products.Count > 0
                    ? products.Max(p => p.ProductId) + 1
                    : 1;

                products.Add(product);
                return RedirectToAction("Index");
            }

            return View(product);
        }
    }
}

namespace ProductCatalog
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new
                {
                    controller = "Product",
                    action = "Index",
                    id = UrlParameter.Optional
                }
            );
        }
    }
}

/*
INDEX VIEW: Views/Product/Index.cshtml

@model IEnumerable<ProductCatalog.Models.Product>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Product Catalog</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            margin: 40px;
        }
        .container {
            width: 90%;
            margin: auto;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .add-button {
            display: inline-block;
            padding: 10px 18px;
            background: green;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th {
            background: #333;
            color: white;
            padding: 12px;
        }
        td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .details {
            color: blue;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Product Catalog</h1>

    <a class="add-button"
       href="@Url.Action("Create", "Product")">
        Add Product
    </a>

    <table>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Description</th>
            <th>Action</th>
        </tr>

        @foreach (var product in Model)
        {
            <tr>
                <td>@product.ProductId</td>
                <td>@product.ProductName</td>
                <td>@product.Category</td>
                <td>₹ @product.Price</td>
                <td>@product.Description</td>
                <td>
                    @Html.ActionLink(
                        "View Details",
                        "Details",
                        "Product",
                        new { id = product.ProductId },
                        new { @class = "details" }
                    )
                </td>
            </tr>
        }
    </table>
</div>
</body>
</html>


DETAILS VIEW: Views/Product/Details.cshtml

@model ProductCatalog.Models.Product

<h1>Product Details</h1>
<p>Product ID: @Model.ProductId</p>
<p>Product Name: @Model.ProductName</p>
<p>Category: @Model.Category</p>
<p>Price: ₹ @Model.Price</p>
<p>Description: @Model.Description</p>

@Html.ActionLink("Back to Catalog", "Index", "Product")


CREATE VIEW: Views/Product/Create.cshtml

@model ProductCatalog.Models.Product

<h1>Add New Product</h1>

@using (Html.BeginForm("Create", "Product", FormMethod.Post))
{
    @Html.AntiForgeryToken()

    <p>
        @Html.LabelFor(m => m.ProductName)
        @Html.TextBoxFor(m => m.ProductName)
        @Html.ValidationMessageFor(m => m.ProductName)
    </p>

    <p>
        @Html.LabelFor(m => m.Category)
        @Html.TextBoxFor(m => m.Category)
        @Html.ValidationMessageFor(m => m.Category)
    </p>

    <p>
        @Html.LabelFor(m => m.Price)
        @Html.TextBoxFor(m => m.Price)
        @Html.ValidationMessageFor(m => m.Price)
    </p>

    <p>
        @Html.LabelFor(m => m.Description)
        @Html.TextBoxFor(m => m.Description)
    </p>

    <button type="submit">Add Product</button>
}

@Html.ActionLink("Back to Catalog", "Index", "Product")
*/

/*
RESULT:
The Product Catalog application demonstrates ASP.NET MVC
Models, Controllers, Views, and Routing.
*/