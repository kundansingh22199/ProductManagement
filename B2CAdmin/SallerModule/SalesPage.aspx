<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="SalesPage.aspx.cs" Inherits="B2CAdmin.SallerModule.SalesPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Sales Product</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Sales Product</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <asp:DropDownList runat="server" ID="ddlSearch" CssClass="form-control">
                            <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
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
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width: 100%; overflow: scroll;">
                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: max-content;">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th>SL/NO</th>
                                                <th>Select</th>
                                                <th>Image</th>
                                                <th>Product Code</th>
                                                <th>Name</th>
                                                <th>Brand</th>
                                                <th>Mrp Price</th>
                                                <th>Product Price</th>
                                                <th>Discount</th>
                                                <th>Sales Price</th>
                                                <th>Size</th>
                                                <th>Catogery</th>
                                                <th>SubCatogery</th>
                                                <th>Mfgdate</th>
                                                <th>ExpireDate</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody style="font-size: 80%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="CheckSelect" runat="server" CssClass="form-control border-bottom-0" />
                                        </td>
                                        <td>
                                            <asp:ImageButton CommandName="Image" CommandArgument='<%# Eval("ProductId") %>' ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:ImageButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBrand" runat="server" Text='<%# Eval("S_Brandname") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMrpPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("MrpPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Text='<%#string.Format("{0:n2}",Eval("Product_Price")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text='<%#string.Format("{0:n2}",Eval("DiscountValue")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSellingPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("SellingPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("CatogeryName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("SubCatogeryName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("MfgDate") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("ExpiryDate") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQuantity" Visible="false" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                            <asp:Label ID="lblStockId" Visible="false" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                            <asp:LinkButton ID="linkBuy" CssClass="btn btn-primary" CommandName="Buy" CommandArgument='<%# Eval("Id") %>' runat="server" Style="width: 90px">Buy Now </asp:LinkButton>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                    <asp:LinkButton ID="linkMultipleBuy" CommandName="MultiItemBuy" CssClass="btn btn-primary" runat="server" Style="width: 90px">Buy Now </asp:LinkButton>
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
    <div id="ActionModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-md">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Action Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body ">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-12">
                                Customer Name
                                <asp:TextBox runat="server" ID="txtName" CssClass="form-control" placeholder="Enter Customer Name"></asp:TextBox>
                            </div>
                            <div class="col-sm-12">
                                Mobile No
                                <asp:TextBox runat="server" ID="txtMobileNo" MaxLength="10" CssClass="form-control" onkeypress="return isNumber(event)" placeholder="Enter Mobile No"></asp:TextBox>
                            </div>
                            <div class="col-sm-6">
                                Quantity
                                <asp:TextBox runat="server" ID="txtQuantity" CssClass="form-control" TextMode="Number" onkeypress="return isNumber(event)" placeholder="Enter Quantity"></asp:TextBox>
                            </div>
                            <div class="col-sm-6">
                                Product Price
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtPrice" CssClass="form-control" placeholder="Enter Price"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnSubmit" class="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="AlertModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-danger">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Conformation Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="text-center"><i class="fa fa-times-circle fa-xl text-danger" aria-hidden="true" style="font-size: 30px"></i></p>
                    <div runat="server" id="errormsg" class="text-danger text-center"></div>
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
    <div id="MultiItemSelectModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Action Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body ">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="messageboxerror">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <strong>Error!</strong> Fill In The Blank
                                        </div>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                Customer Name
                                                    <asp:TextBox runat="server" ID="txtCustomerName" CssClass="form-control" placeholder="Enter Customer Name"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4">
                                                Mobile No
                                                    <asp:TextBox runat="server" ID="txtCustomerMobile" MaxLength="10" CssClass="form-control" onkeypress="return isNumber(event)" placeholder="Enter Mobile No"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4">
                                                Grand Total
                                                    <asp:TextBox runat="server" ReadOnly="true" ID="txtGrandTotal" CssClass="form-control" placeholder="Enter Price"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <asp:Repeater ID="repBuyProduct" runat="server" OnItemCommand="repBuyProduct_ItemCommand" OnItemDataBound="repBuyProduct_ItemDataBound">
                                            <HeaderTemplate>
                                                <div class="table-responsive" style="height: 300px; width: 100%; overflow: scroll;">
                                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: 100%;">
                                                        <thead class="bg-primary text-white">
                                                            <tr>
                                                                <th>SL/NO</th>
                                                                <%--<th>Product Code</th>--%>
                                                                <th>Product Name</th>
                                                                <th>Price</th>
                                                                <th>Quantity</th>
                                                                <th>Total Price</th>
                                                            </tr>
                                                        </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tbody style="font-size: 85%;">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                                            <asp:Label ID="lblProductCode" Visible="false" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSellingPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("SellingPrice")) %>'></asp:Label>
                                                        </td>
                                                        <td style="width: 200px" class=" m-0 p-0">
                                                            <div class="input-group">
                                                                <asp:LinkButton runat="server" ID="linkQuantityMinus" CssClass="btn btn-primary" CommandName="QuantityMinus"><i class="fas fa-minus"></i></asp:LinkButton>
                                                                <asp:Label ID="lblQuantity" runat="server" CssClass="form-control border-bottom-0 text-center" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                <div class="input-group-prepend" style="background-color: white;">
                                                                    <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block; background-color: white; border: none">
                                                                        <asp:LinkButton runat="server" ID="linkQuantityPlus" CssClass="btn btn-primary" CommandName="QuantityPlus"><i class="fas fa-plus"></i></asp:LinkButton>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblStockQuantity" Visible="false" runat="server" Text='<%# Eval("StockQuantity") %>'></asp:Label>
                                                            <asp:Label ID="lblStockId" Visible="false" runat="server" Text='<%# Eval("StockId") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTotalPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("SellingPrice")) %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                                </div>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnbuyAll" class="btn btn-primary" Text="Buy All" OnClick="btnbuyAll_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div id="OrderPrintModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Order Print</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body ">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:Repeater ID="RepOrderPrint" runat="server">
                                            <HeaderTemplate>
                                                <div class="table-responsive" style="height: 300px; width: 100%; overflow: scroll;">
                                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: 100%;">
                                                        <thead class="bg-success text-white">
                                                            <tr>
                                                                <th>SL/NO</th>
                                                                <th>Customer Mobile</th>
                                                                <th>Product Code</th>
                                                                <th>Product Name</th>
                                                                <th>Price</th>
                                                                <th>Quantity</th>
                                                                <th>TotalPrice</th>
                                                                <th>Status</th>
                                                            </tr>
                                                        </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tbody style="font-size: 80%;">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCustomerMobile" runat="server" Text='<%# Eval("CustomerMobile") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSellingPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("Price")) %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label7" runat="server" Text='<%#string.Format("{0:n2}",Eval("TotalPrice")) %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                                </div>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnPrintOrder" class="btn btn-success" Text="Print" OnClick="btnPrintOrder_Click" />
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
