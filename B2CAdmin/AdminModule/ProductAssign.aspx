<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="ProductAssign.aspx.cs" Inherits="B2CAdmin.AdminModule.ProductAssign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Product Assign</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Product Assign</li>
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
                        <asp:TextBox runat="server" ID="txtSearch" placeholder="Search Here....!!" class="form-control" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" />
                        </div>
                    </div>
                    <div class="col-md-7 text-right">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" Text="Export to excel" />
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" >
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" id="myTable" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>
                                                    <asp:Label ID="headsl" runat="server" Text="SL/NO"></asp:Label></th>
                                                <th>Product Image</th>
                                                <th>Product Code</th>
                                                <th>Product Name</th>
                                                <th>Serial No</th>
                                                <th>Catogery</th>
                                                <th>Sub Catogery</th>
                                                <th colspan="4">
                                                    <asp:Label ID="headop" runat="server" Text="Operator"></asp:Label></th>

                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Image ID="lblProductImage" runat="server" ImageUrl="" class="img-size-50 img-circle" Style="height: 36px; width: 36px;"></asp:Image>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductCode" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductName" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblId" runat="server" Text="" Visible="false"></asp:Label>
                                        <asp:LinkButton ID="linkDetails" CommandName="Details" runat="server"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="linkUpdate" CommandName="Update" runat="server"><i class="fas fa-edit fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" CommandName="Delete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this Product?');"><i class="fas fa-trash fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton2" CommandName="Stock" runat="server">
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/AdminModule/dist/img/inventory.png" Style="height: 35px; width: 35px;" />
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                            </div>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        
                    </div>
                   
                </div>
            </div>
        </section>
    </div>
</asp:Content>
