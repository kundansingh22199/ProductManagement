﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="SellarStock.aspx.cs" Inherits="B2CAdmin.SallerModule.SellarStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Sellar Stock Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Sellar Stock Management</li>
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
                        <asp:TextBox runat="server" ID="txtSearch" placeholder="Search Here....!!" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" />
                        </div>
                    </div>
                    <div class="col-md-6 text-right">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" Text="Export to excel" />
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width:100%; overflow: scroll;">
                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: max-content;  ">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th>SL/NO</th>
                                                <th>Image</th>
                                                <th>Product Code</th>
                                                <th>Name</th>
                                                <th>Brand</th>
                                                <th>Serial No</th>
                                                <th>HSN Code</th>
                                                <th>Quantity</th>
                                                <th>Mrp Price</th>
                                                <th>Purchase Price</th>
                                                <th>Product Price</th>
                                                <th colspan="2">Sales Price</th>
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
                                            <asp:Image ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:Image>
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
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("HSNCode") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMrpPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("MrpPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("Price")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Text='<%#string.Format("{0:n2}",Eval("Product_Price")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label9" runat="server" Text='<%#string.Format("{0:n2}",Eval("SellingPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="linkStockPrice" CommandName="SetPrice" CommandArgument='<%# Eval("Id") %>' runat="server"><i class="fas fa-edit fa-xl" aria-hidden="true" style="font-size:20px"></i> </asp:LinkButton>
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
                                            <asp:LinkButton ID="LinkButton1" CommandName="Add" CommandArgument='<%# Eval("StockId") %>' runat="server"><i class="fas fa-plus fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
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
    <div id="SellPriceModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-md ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Set Selling Price</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label10" for="">Mrp Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtMrpPrice" class="form-control mb-2" oninput="CalculateFunction();"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label13" for="">Purchase Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtPurchase" class="form-control mb-2" oninput="CalculateFunction();"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label6" for="">Set Product Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtProductPrice" class="form-control mb-2" oninput="CalculateFunction();"></asp:TextBox>
                        </div>
                        <div class="col-sm-12">
                            <asp:Label runat="server" ID="Label5">Discount<span style="color:red"><b>*</b></span> </asp:Label>
                            <div class="input-group mb-2">
                                <asp:TextBox runat="server" ID="txtDiscount" placeholder="Enter Product Size" class="form-control" oninput="CalculateFunction();"></asp:TextBox>
                                <div class="input-group-prepend">
                                    <asp:DropDownList ID="ddlDiscountType" class="form-control" runat="server" oninput="CalculateFunction();">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="PER" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="RS" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label11" for="">Sales Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtSalesPrice" class="form-control mb-2 bg-white"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnSetPrice" class="btn btn-primary" Text="Set Price" OnClick="btnSetPrice_Click" />
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
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Alert Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="text-center"><i class="fa fa-times-circle fa-xl text-danger" aria-hidden="true" style="font-size: 30px"></i></p>
                    <h6 runat="server" id="msg" class="text-danger"></h6>
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
    <script>
        document.getElementById('<%= txtSalesPrice.ClientID %>').readOnly = true;
        document.getElementById('<%= txtMrpPrice.ClientID %>').readOnly = true;
        document.getElementById('<%= txtPurchase.ClientID %>').readOnly = true;
        function CalculateFunction() {
            debugger
            var ProductPrice = parseFloat(document.getElementById('<%= txtProductPrice.ClientID %>').value);
            var DiscountPrice = parseFloat(document.getElementById('<%= txtDiscount.ClientID %>').value);
            var discountType = document.getElementById('<%= ddlDiscountType.ClientID %>').value;

            var D = 0;
            if (ProductPrice == "" || ProductPrice == null) {
                D = 0;
            }
            if (discountType == '1') {
                D = ProductPrice - (ProductPrice * DiscountPrice) / 100;
            }
            else if (discountType == '2') {
                D = ProductPrice - DiscountPrice;
            }
            else {
                D = ProductPrice;
            }
            D = D.toFixed(4)
            parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = D);
        }
        function Confirm() {
            var ProductPrice = parseFloat(document.getElementById('<%= txtProductPrice.ClientID %>').value);
            var MrpPrice = parseFloat(document.getElementById('<%= txtMrpPrice.ClientID %>').value);
            var PurchasePrice = parseFloat(document.getElementById('<%= txtPurchase.ClientID %>').value);

        }
    </script>
    <!-- Product Modal End -->
</asp:Content>
