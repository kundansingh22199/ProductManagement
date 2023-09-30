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
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand" OnItemDataBound="Repeater1_ItemDataBound">
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width:100%; overflow: scroll;">
                                <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow-x: scroll; width: max-content">
                                    <thead class="bg-primary text-white">
                                        <tr>
                                            <th>SL/NO</th>
                                            <th>Payment Mode</th>
                                            <th>PaymentReceipt</th>
                                            <th>OrderId</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>TotalPrice</th>
                                            <th>Status</th>
                                            <th>OrderDate</th>
                                            <th colspan="3">Action</th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("PaymentMode") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Image ID="lblReceiptImage" runat="server" ImageUrl='<%# Eval("PaymentReceipt") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:Image>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblOrderId" runat="server" Text='<%# Eval("OrderId") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text='<%#string.Format("{0:n2}",Eval("Price")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text='<%#string.Format("{0:n2}",Eval("TotalPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server" CssClass="rounded-pill badge text-white" Text='<%# Eval("Status") %>'></asp:Label>
                                        </td>
                                       <td>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderDate") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStockId" runat="server" Visible="false" Text='<%# Eval("StockId") %>'></asp:Label>
                                            <asp:Label ID="lblOrderBy" runat="server" Visible="false" Text='<%# Eval("OrderBy") %>'></asp:Label>
                                            <asp:LinkButton ID="linkDetails" CommandName="Details" CommandArgument='<%# Eval("Id") %>' runat="server" CssClass="text-primary"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:30px"></i> </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="linkApproved" CommandName="Approved" CommandArgument='<%# Eval("Id") %>' runat="server" CssClass="text-success"><i class="fas fa-check-circle fa-xl" aria-hidden="true" style="font-size:30px"></i> </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="linkReject" CommandName="Reject" CommandArgument='<%# Eval("Id") %>' runat="server" CssClass="text-danger"><i class="fas fa-times-circle fa-xl" aria-hidden="true" style="font-size:30px"></i> </asp:LinkButton>
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
        <div class="modal-dialog modal-sm ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Action Dialog</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body ">
                    <h6 runat="server" id="msg" class="text-danger"></h6>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnCancle" class="btn btn-danger" Text="Cancle" OnClick="btnCancle_Click" />
                    <asp:Button runat="server" ID="btnSucess" class="btn btn-primary" Text="Approve" OnClick="btnSucess_Click" />
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
