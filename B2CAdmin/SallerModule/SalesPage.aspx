﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="SalesPage.aspx.cs" Inherits="B2CAdmin.SallerModule.SalesPage" %>

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
                                <div class="table-responsive" style="height: 400px; width: 100%; overflow: scroll;">
                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow: scroll; width: max-content;">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th>SL/NO</th>
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
                                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" CommandName="Buy" CommandArgument='<%# Eval("StockId") %>' runat="server" Style="width: 90px">Buy Now </asp:LinkButton>
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
                                <asp:TextBox runat="server" ID="txtMobileNo" MaxLength="10" CssClass="form-control" onkeypress="return isNumber(event)"  placeholder="Enter Mobile No"></asp:TextBox>
                            </div>
                            <div class="col-sm-6">
                                Quantity
                                <asp:TextBox runat="server" ID="txtQuantity" CssClass="form-control" TextMode="Number" onkeypress="return isNumber(event)"  placeholder="Enter Quantity"></asp:TextBox>
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
                    <p class="text-center"><i class="fa fa-times-circle fa-xl text-danger" aria-hidden="true" style="font-size:30px"></i></p>
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
                    <p class="text-center"><i class="fa fa-check-circle fa-xl text-success" aria-hidden="true" style="font-size:30px"></i>
                    </p>
                    <div runat="server" id="msgsuccess" class="text-success text-center"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
