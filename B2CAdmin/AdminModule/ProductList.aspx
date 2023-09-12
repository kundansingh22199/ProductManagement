<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="B2CAdmin.AdminModule.ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            width: 100%;
            background-color: white;
        }

        .controls-container:after {
            content: '';
            display: block;
            clear: both;
        }

        .control {
            position: relative;
            float: left;
            width: 16.5%;
            height: 100%;
        }

        .control-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid white;
            position: absolute;
            transform: translateX(-50%) translateY(-50%);
            top: 50%;
            left: 50%;
            cursor: pointer;
            color: white;
            font-size: 30px;
            text-align: center;
            line-height: 40px;
            transition: all .3s;
        }

            .control-btn:hover {
                background-color: rgba(98, 89, 89, .4);
            }

        #images-container {
            height: 200px;
            position: relative;
        }

        .image {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            opacity: 0;
            transition: all .5s;
        }

            .image[data-active="active"] {
                opacity: 1;
            }
            
    </style>
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
                     <div class="col-md-12 text-left">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" OnClick="btnExportInExcel_Click" Text="Export to excel"/>
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th><asp:Label ID="headsl" runat="server" Text="SL/NO"></asp:Label></th>
                                                <th>Product Image</th>
                                                <th>Product Code</th>
                                                <th>Product Name</th>
                                                <th>Product Serial No</th>
                                                <th colspan="4"><asp:Label ID="headop" runat="server" Text="Operator"></asp:Label></th>

                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Image ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="img-size-50 img-circle" style="height:36px; width:36px;" ></asp:Image>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
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
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/AdminModule/dist/img/inventory.png" style="height:35px;width:35px;" /></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                            </div></div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div class="modal fade  bd-example-modal-sm" id="ProductDetailsModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">
                                <div class="modal-content" runat="server" id="divmodel">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align: center!important; font-family: serif">Product Details</h5>
                                        <button type="button" runat="server" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" style="width: 90%; margin: auto; box-shadow: 0px 0px 5px 0px">
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-sm-7">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <b>Product Code :</b><asp:Label ID="lblProductCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Product Name :</b><asp:Label ID="lblProductName" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <b>Catogery :</b><asp:Label ID="lblCatogery" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <b>Sub Catogery :</b><asp:Label ID="lblSubCatogery" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Bar Code :</b><asp:Label ID="lblBarCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>HSN Code :</b><asp:Label ID="lblHsnCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Product Details :</b><asp:Label ID="lblProductDetails" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Serial No :</b><asp:Label ID="lblSerialNo" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Other Details :</b><asp:Label ID="lblOtherDetails" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <%--<div class="col-sm-6">
                                                            <b>Create Date :</b><asp:Label ID="lblCreateDate" class="form-control" runat="server"></asp:Label>
                                                        </div>--%>
                                                        <div class="col-sm-6">
                                                            <asp:Label ID="lblProductId" class="form-control" runat="server" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>
                                                   
                                                </div>
                                                <div class="col-sm-5">
                                                    <div class="container">
                                                        <div id="images-container">
                                                            <img src="#" class="image image-1" runat="server"  id="image1" alt="Product Image 1" data-active="active">
                                                            <img src="#" class="image image-2" runat="server"  id="image2" alt="Product Image 2">
                                                            <img src="#" class="image image-3" runat="server"  id="image3" alt="Product Image 3">
                                                            <img src="#" class="image image-4" runat="server"  id="image4" alt="Product Image 4">
                                                            <img src="#" class="image image-5" runat="server"  id="image5" alt="Product Image 5">
                                                            <img src="#" class="image image-6" runat="server"  id="image6" alt="Product Image 6">
                                                        </div>
                                                        <div id="controls-container" style="background-image: url(dist/img/backend.jpg); height: 55px;">
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image1">1</div>
                                                            </div>
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image2">2</div>
                                                            </div>
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image3">3</div>
                                                            </div>
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image4">4</div>
                                                            </div>
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image5">5</div>
                                                            </div>
                                                            <div class="control">
                                                                <div class="control-btn" data-image="image6">6</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnPrint" runat="server" class="btn btn-secondary" Text="Print" OnClick="btnPrint_Click" />
                                        <asp:Button ID="Btn_back" runat="server" class="btn btn-success" Text="Go Back" OnClick="Btn_back_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            function ShowPopup() {
                                $("#ProductDetailsModel").modal("show");
                                $("#ProductDetailsModel").css('background', 'inherit');
                            }



                            var controlsContainer = document.getElementById('controls-container'),
                                allImages = document.querySelectorAll('.image'),
                                imagesContainer = document.getElementById('images-container');


                            controlsContainer.onclick = function (e) {
                                debugger
                                var target = e.target,
                                    dataTarget = target.getAttribute('data-image'),
                                    activeImage = document.getElementById(dataTarget);

                                if (dataTarget) {
                                    for (var i = 0; i < allImages.length; i++) {
                                        allImages[i].removeAttribute('data-active');
                                    }
                                    activeImage.setAttribute('data-active', 'active');
                                }
                            }

                        </script>
                    </div>
                    <div class="col-md-12" runat="server" id="dv1" visible="false">
                        <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>SL/NO</th>
                                                <th>Product Code</th>
                                                <th>Product Name</th>
                                                <th>Product Serial No</th>
                                                <th>HSN Code</th>
                                                <th>Bar Code</th>
                                                <th>Product Details</th>
                                                <th>Other Details</th>
                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("HSNCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("BarCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("ProductDetails") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("OtherDetails") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                            </div></div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
