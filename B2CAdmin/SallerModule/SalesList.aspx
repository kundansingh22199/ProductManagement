<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="SalesList.aspx.cs" Inherits="B2CAdmin.SallerModule.SalesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Sales List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="DashBoard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Sales List</li>
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
                        <asp:DropDownList runat="server" ID="ddlSearch" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                            <asp:ListItem Value="ByCatogery" Text="Catogery Name"></asp:ListItem>
                            <asp:ListItem Value="BySubCatogery" Text="Sub Catogery Name"></asp:ListItem>
                            <asp:ListItem Value="ByDate" Text="Search By Date"></asp:ListItem>
                            <asp:ListItem Value="ByBrand" Text="Brand Name"></asp:ListItem>
                            <asp:ListItem Value="ByProductName" Text="Product Name"></asp:ListItem>
                            <asp:ListItem Value="ByProductCode" Text="Product Code"></asp:ListItem>
                            <asp:ListItem Value="ByCustomerId" Text="Customer Id"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3" runat="server" id="divDate1" visible="false">
                        From 
                        <asp:TextBox runat="server" ID="txtfromDate" TextMode="Date" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3" runat="server" id="divDate2" visible="false">
                        To
                        <asp:TextBox runat="server" ID="txtoDate" TextMode="Date" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3" runat="server" id="divText">
                        <asp:TextBox runat="server" ID="txtsearch" class="form-control"></asp:TextBox>
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
                                    <table id="bootstrap-data-table-export" class="table table-bordered " style="overflow-x: scroll; width: max-content">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th>SL/NO</th>
                                                <th>Image</th>
                                                <th>Customer Id</th>
                                                <th>Product Name</th>
                                                <th>Brand</th>
                                                <th>Product Code</th>
                                                <th>Size</th>
                                                <th>Catogery</th>
                                                <th>SubCatogery</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Total Price</th>
                                                <th>Action</th>
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
                                            <asp:ImageButton CommandName="Image" CommandArgument='<%# Eval("ProductId") %>' ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:ImageButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("S_CustomerId") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("S_Brandname") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("S_ProductCode") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("CatogeryName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("SubCatogeryName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("S_Quantity") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text='<%#string.Format("{0:n2}",Eval("S_Price")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text='<%#string.Format("{0:n2}",Eval("S_TotalPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="linkRefund" CommandName="Refund" CommandArgument='<%# Eval("S_Id") %>' runat="server" CssClass="btn btn-danger font-weight-bold">Refund </asp:LinkButton>
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
</asp:Content>
