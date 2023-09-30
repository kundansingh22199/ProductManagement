<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="B2CAdmin.SallerModule.ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Product List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Product List</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <%--<div class="col-md-2">
                        <asp:DropDownList runat="server" ID="ddlCatogery" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCatogery_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList runat="server" ID="ddlSubCatogery" CssClass="form-control" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>--%>
                    <div class="col-md-3">
                        <asp:DropDownList runat="server" ID="ddlSearch" CssClass="form-control" >
                            <asp:ListItem Value="0" Text="All"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Catogery Name"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Sub Catogery Name"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Brand Name"></asp:ListItem>
                            <asp:ListItem Value="4" Text="Product Name"></asp:ListItem>
                            <asp:ListItem Value="5" Text="Size Name"></asp:ListItem>
                            <asp:ListItem Value="6" Text="Serial No"></asp:ListItem>
                            <asp:ListItem Value="7" Text="Product Code"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ID="txtSearch" placeholder="Search Here....!!" class="form-control" AutoPostBack="true" OnTextChanged="btnSearch_Click"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <%--<div class="col-md-4 text-right">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" Text="Export to excel" />
                    </div>--%>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width: 100%; overflow: scroll;">
                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: max-content; max-width: max-content;">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th>
                                                    <asp:Label ID="Label1" runat="server" Text="SL/NO"></asp:Label></th>
                                                <th>Image</th>
                                                <th>Product Code</th>
                                                <th>Catogery</th>
                                                <th>SubCatogery</th>
                                                <th>Brand</th>
                                                <th>Name</th>
                                                <th>Size</th>
                                                <th>Mrp Price</th>
                                                <th>Sales Price</th>
                                                <th>Discount(%/RS)</th>
                                                <th>Tax(%)</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody style="font-size: 90%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:ImageButton CommandName="Image" CommandArgument='<%# Eval("ProductId") %>' ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:ImageButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                        </td>
                                         <td>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("CatogeryName") %>'></asp:Label>
                                        </td>
                                         <td>
                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("SubCatogeryName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBrand" runat="server" Text='<%# Eval("S_BrandName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text='<%#string.Format("{0:n2}",Eval("MrpPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text='<%#string.Format("{0:n2}",Eval("SalesPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label17" runat="server" Text='<%#string.Format("{0:n2}", Eval("Discount")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label18" runat="server" Text='<%#string.Format("{0:n2}", Eval("IGST")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>
                                            <asp:LinkButton ID="linkDetails" CommandName="Order" runat="server" CssClass="text-primary"><i class="fa fa-shopping-cart fa-xl" aria-hidden="true" style="font-size:30px"></i> </asp:LinkButton>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div style="overflow: hidden;">
                            <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnPage" CssClass="btn btn-primary" CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" ForeColor="White" Font-Bold="True"><%# Container.DataItem %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                    </div>

                </div>
            </div>
        </section>
    </div>
    <!-- Product Modal -->
    <div id="ProductModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Product Order</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <%--<div class="col-sm-6">
                            <asp:Label runat="server" ID="Label29" for="">Product Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtProductName" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-sm-6">
                            <asp:Label runat="server" ID="Label15" for="">Brand Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtBrand" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label32" for="">Serial No</asp:Label>
                            <asp:TextBox runat="server" ID="txtSerialNo" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label16" for="">BarCode</asp:Label>
                            <asp:TextBox runat="server" ID="txtBarcode" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label7" for="">HSN Code</asp:Label>
                            <asp:TextBox runat="server" ID="txtHsnCode" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label11" for="">Size/Weight</asp:Label>
                            <asp:TextBox runat="server" ID="txtSize" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label8" for="">Mrp Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtMrpPrice" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>--%>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label13" for="">Discount</asp:Label>
                            <asp:TextBox runat="server" ID="txtDiscount" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label14" for="">Tax</asp:Label>
                            <asp:TextBox runat="server" ID="txtTax" ReadOnly="true" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label4" for="">Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtPrice" ReadOnly="true" class="form-control mb-2 bg-white" oninput="CalculatePrice();"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label10" for="">Total Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtTotalPrice" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                        <%--<div class="col-md-6">
                            <div class="row">
                                
                            </div>
                        </div>--%>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label9" for="">Quantity</asp:Label>
                            <asp:TextBox runat="server" TextMode="Number" ID="txtQuantity" class="form-control mb-2" oninput="CalculatePrice();"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label2" for="">Payment Mode</asp:Label>
                            <asp:DropDownList runat="server" ID="ddlPaymentMode" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMode_SelectedIndexChanged">
                                <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Online Mode"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Offline Mode"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-6" runat="server" id="lblReceipt" visible="false">
                            <asp:Label runat="server" ID="Label12" for="">Payment Reciept</asp:Label>
                            <asp:FileUpload runat="server" ID="ReceiptUpload" onchange="loadFile(event)" CssClass="form-control my-auto" />
                        </div>
                        <div class="col-sm-6" runat="server" id="lblimage" visible="false">
                            <asp:Label runat="server" ID="lblStock" Visible="false"></asp:Label>
                            <asp:Image ID="ReceiptImage" runat="server" CssClass="img-fluid" Style="height: 150px; width: 100%;" />
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnOrderProduct" class="btn btn-primary" Text="Order" OnClick="btnOrderProduct_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Product Modal End -->
    <div id="AlertModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-danger">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Alert Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="text-center"><i class="fa fa-times-circle fa-xl text-danger" aria-hidden="true" style="font-size: 30px"></i></p>
                    <div runat="server" id="msg" class="text-danger text-center"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="ConformationModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Conformation Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="text-center">
                        <i class="fa fa-check-circle fa-xl text-success" aria-hidden="true" style="font-size: 30px"></i>
                    </p>
                    <div runat="server" id="msgsuccess" class="text-success text-center"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="ImageModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-md ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Product Image</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="card-body">
                            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image1" alt="Product Image 1" data-active="active" Style="width: 100%; height: 300px" />
                                    </div>
                                    <div class="carousel-item">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image2" alt="Product Image 2" Style="width: 100%; height: 300px" />
                                    </div>
                                    <div class="carousel-item">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image3" alt="Product Image 3" Style="width: 100%; height: 300px" />
                                    </div>
                                    <div class="carousel-item">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image4" alt="Product Image 4" Style="width: 100%; height: 300px" />
                                    </div>
                                    <div class="carousel-item">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image5" alt="Product Image 5" Style="width: 100%; height: 300px" />
                                    </div>
                                    <div class="carousel-item">
                                        <asp:Image class="img-fluid d-block" runat="server" ID="image6" alt="Product Image 6" Style="width: 100%; height: 300px" />
                                    </div>
                                </div>
                                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev" style="color: red; background: red; height: 25px; width: 35px; position: absolute; top: 95%"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a>
                                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next" style="color: red; background: red; height: 25px; width: 35px; position: absolute; top: 95%"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            debugger
            var A = parseFloat(document.getElementById('<%= txtPrice.ClientID %>').value);
            document.getElementById('<%= txtTotalPrice.ClientID %>').value = A;

        })
        document.getElementById('<%= txtTotalPrice.ClientID %>').readOnly = true;
        function CalculatePrice() {
            debugger

            var A = parseFloat(document.getElementById('<%= txtPrice.ClientID %>').value);
            var B = parseFloat(document.getElementById('<%= txtQuantity.ClientID %>').value);
            if (!isNaN(A) && isNaN(B)) {
                document.getElementById('<%= txtTotalPrice.ClientID %>').value = A;
            }
            else if (isNaN(A) && !isNaN(B)) {
                document.getElementById('<%= txtTotalPrice.ClientID %>').value = B;
            }
            else {
                var C = A * B;
                document.getElementById('<%= txtTotalPrice.ClientID %>').value = C;
            }
        }



        function ShowOrderPopup() {
            debugger;
            $("#ProductModel").modal("show");
            $("#ProductModel").css('background', 'inherit');
        }
        var loadFile = function (event) {
            debugger;
            var image = document.getElementById('<%= ReceiptImage.ClientID %>');
            image.src = URL.createObjectURL(event.target.files[0]);
        };
        var m1;
        var f1 = document.getElementById("ReceiptUpload");
        var v1 = document.getElementById("1");
        f1.addEventListener("change", function (e) {
            m1 = new FileReader();
            m1.onload = function (e) {
                v1.src = e.target.result;
            };
            m1.readAsDataURL(this.files[0]);
        });
    </script>
</asp:Content>
