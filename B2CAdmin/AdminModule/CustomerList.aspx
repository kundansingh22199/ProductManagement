﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="CustomerList.aspx.cs" Inherits="B2CAdmin.AdminModule.CustomerList" %>
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
                    <div class="col-md-3 mb-2">
                        Search By
                        <asp:DropDownList runat="server" ID="ddlSearch" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                            <asp:ListItem Value="CustomerName" Text="Customer Name"></asp:ListItem>
                            <asp:ListItem Value="UserId" Text="Customer ID"></asp:ListItem>
                            <asp:ListItem Value="SellarMobileNo" Text="Sellar Mobile No"></asp:ListItem>
                            <asp:ListItem Value="ByDate" Text="Search By Date"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3 mb-2" runat="server" id="divDate1" visible="false">
                        From 
                        <asp:TextBox runat="server" ID="txtfromDate" TextMode="Date" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3 mb-2" runat="server" id="divDate2" visible="false">
                        To
                        <asp:TextBox runat="server" ID="txtoDate" TextMode="Date" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3 mb-2" runat="server" id="divText">
                        Search here..!!
                        <asp:TextBox runat="server" ID="txtsearch" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2 mb-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" >
                            <HeaderTemplate>
                                <div class="table-responsive" style="height: 400px; width:100%; overflow: scroll;">
                                <table id="bootstrap-data-table-export" class="table table-bordered " style="width: 100%">
                                    <thead class="bg-primary text-white">
                                        <tr>
                                            <th>SL/NO</th>
                                            <th>Customer Id</th>
                                            <th>Customer Name</th>
                                            <th>Mobile No</th>
                                            <th>Create By</th>
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
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CreateBy") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("CreateDate") %>'></asp:Label>
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
</asp:Content>