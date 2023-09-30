<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="CustomerList.aspx.cs" Inherits="B2CAdmin.SallerModule.CustomerList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Customer List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="DashBoard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Customer List</li>
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
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" >
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width:100%; overflow: scroll;">
                                <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow-x: scroll; width: 100%">
                                    <thead class="bg-primary text-white">
                                        <tr>
                                            <th>SL/NO</th>
                                            <th>Customer Id</th>
                                            <th>Customer Name</th>
                                            <th>Mobile No</th>
                                            <th>Create Date</th>
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
                                            <asp:Label ID="lblCId" runat="server" Text='<%# Eval("CustomerId") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("C_Name") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMono" runat="server" Text='<%# Eval("C_MoNo") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CreateDate") %>'></asp:Label>
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
