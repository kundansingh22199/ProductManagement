<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="B2CAdmin.AdminModule.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-control {
            box-shadow: 2px;
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
                        <h1>Add Product</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Add Product</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-12">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Form</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <div class="card-body">
                                <div class="card card-primary">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="alert alert alert-dismissible bg-success" runat="server" visible="false" id="messagebox">
                                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                    <strong>Success!</strong>Data has been successfully Inserted .
                                                    <span runat="server" id="txtmess"></span>
                                                </div>
                                                <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="messageboxerror">
                                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                    <strong>Error!</strong> something wrong
                                                </div>
                                            </div>
                                            <div class="col-md-7">
                                                <div class="row">
                                                    <%--<div class="col-md-12">
                                                        <asp:Label runat="server" ID="Label1" for="txtProdectCode">Product Code</asp:Label>
                                                        <div class="input-group">
                                                            <asp:TextBox runat="server" ID="txtProdectCode" Enabled="false" placeholder="Enter Product Code" class="form-control"></asp:TextBox>
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text" style="padding: 0px; margin: 0px; padding-left: 10px; padding-right: 10px;">
                                                                    <asp:Button runat="server" ID="btnProductCode" Text="R" Style="border: none;" OnClick="btnProductCode_Click" />
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-sm-6">
                                                        <asp:Label runat="server" ID="Label2" for="txtProductName">Product Name<span style="color:red"><b>*</b></span></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtProductName" placeholder="Enter Product Name" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <asp:Label runat="server" ID="Label14" for="txtSerialNo">SerialNo<span style="color:red"><b>*</b></span></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtSerialNo" placeholder="Enter SerialNo" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:Label runat="server" ID="Label4" for="ddlProductCatogery">Product Catogery<span style="color:red"><b>*</b></span></asp:Label>
                                                        <div class="input-group mb-2">
                                                            <asp:DropDownList ID="ddlProductCatogery" AutoPostBack="true" class="custom-select form-control-border" runat="server" OnSelectedIndexChanged="ddlProductCatogery_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                                    <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#CatogryModel"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:Label runat="server" ID="Label5">Product Sub Catogery<span style="color:red"><b>*</b></span></asp:Label>
                                                        <div class="input-group mb-2">
                                                            <asp:DropDownList ID="ddlProductSubCatogery" class="custom-select form-control-border" runat="server">
                                                            </asp:DropDownList>
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                                    <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#SubCatogeryModel"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <asp:Label runat="server" ID="Label3" for="txtHsnCode">HSN Code<span style="color:red"><b>*</b></span></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtHsnCode" placeholder="Enter HSN Code" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <asp:Label runat="server" ID="Label8" for="txtBarCode">BarCode<span style="color:red"><b>*</b></span></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtBarCode" placeholder="Enter BarCode" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <asp:Label runat="server" ID="Label7" for="txtProductDetails">Product Details<span style="color:red"><b>*</b></span></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtProductDetails" placeholder="Enter Product Details" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <asp:Label runat="server" ID="Label13" for="txtOtherDetails">Other Details</asp:Label>
                                                        <asp:TextBox runat="server" TextMode="MultiLine" ID="txtOtherDetails" placeholder="Enter Other Details" class="form-control mb-2"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-5">
                                                <div class="card-body">
                                                    <div class="row" style="width: 100%">
                                                        <div class="col-sm-12">
                                                            <img src="dist/img/avatar5.png" id="output" style="width: 100%; height: 250px;margin-bottom:10px" />
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="input-group-prepend">
                                                                <asp:FileUpload runat="server" ID="imgupload1" CssClass="form-control mb-2 bg-light" onchange="loadFile(event)" />
                                                                <span class="input-groupt" style="color: red">
                                                                    <b>*</b>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="input-group-prepend">
                                                                <asp:FileUpload runat="server" CssClass="form-control mb-2 bg-light" ID="imgupload2" onchange="loadFile(event)" />
                                                                <span class="input-groupt" style="color: red">
                                                                    <b>*</b>
                                                                </span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <asp:FileUpload runat="server" CssClass="form-control mb-2 bg-light" ID="imgupload3" onchange="loadFile(event)" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:FileUpload runat="server" CssClass="form-control mb-2 bg-light" ID="imgupload4" onchange="loadFile(event)" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:FileUpload runat="server" CssClass="form-control mb-2 bg-light" ID="imgupload5" onchange="loadFile(event)" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:FileUpload runat="server" CssClass="form-control mb-2 bg-light" ID="imgupload6" onchange="loadFile(event)" />
                                            </div>
                                        </div>
                                        <div class="col-md-12 pt-3">
                                            <asp:Button runat="server" ID="btnSubmit" Text="ADD PRODUCT" class="btn btn-primary mb-2 ml-2" OnClick="btnSubmit_Click" />
                                            <asp:Button runat="server" ID="btnStock" Text="ADD Stock" class="btn btn-warning mb-2 ml-2" Visible="false" OnClick="btnStock_Click" />
                                            <asp:Button runat="server" ID="btnUpdate" Text="UPDATE PRODUCT" class="btn btn-primary mb-2 ml-2" Visible="false" OnClick="btnUpdate_Click" />
                                            <asp:Button runat="server" ID="btnReset" Text="RESET" class="btn btn-danger mb-2 ml-2 mr-2" OnClick="btnReset_Click" />
                                        </div>
                                    </div>

                                    <div class="card-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                </div>
                <script type="text/javascript">
                    var loadFile = function (event) {
                        var image = document.getElementById("output");
                        image.src = URL.createObjectURL(event.target.files[0]);
                    };

                    var m1, m2, m3, m4, m5, m6;
                    var f1 = document.getElementById("imgupload1");
                    var f2 = document.getElementById("imgupload2");
                    var f3 = document.getElementById("imgupload3");
                    var f4 = document.getElementById("imgupload4");
                    var f5 = document.getElementById("imgupload5");
                    var f6 = document.getElementById("imgupload6");
                    var v1 = document.getElementById("1");
                    f1.addEventListener("change", function (e) {
                        m1 = new FileReader();
                        m1.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m1.readAsDataURL(this.files[0]);
                    });
                    f2.addEventListener("change", function (e) {
                        m2 = new FileReader();
                        m2.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m2.readAsDataURL(this.files[0]);
                        v1.setAttribute('data-active', 'active');
                    });
                    f3.addEventListener("change", function (e) {
                        m3 = new FileReader();
                        m3.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m3.readAsDataURL(this.files[0]);
                    });
                    f4.addEventListener("change", function (e) {
                        m4 = new FileReader();
                        m4.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m4.readAsDataURL(this.files[0]);
                    });
                    f5.addEventListener("change", function (e) {
                        m5 = new FileReader();
                        m5.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m5.readAsDataURL(this.files[0]);
                    });
                    f6.addEventListener("change", function (e) {
                        m6 = new FileReader();
                        m6.onload = function (e) {
                            v1.src = e.target.result;
                        };
                        m6.readAsDataURL(this.files[0]);
                    });
                    </script>
            </div>
        </section>
        <!-- /.container-fluid -->
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <!-- Catogery Modal -->
    <div id="CatogryModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Add Catogery</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label16" for="">Catogery Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtAddCatogery" placeholder="Enter Catogery Name" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label17" for="">Catogery Description</asp:Label>
                            <asp:TextBox runat="server" ID="txtCatogeryDescription" placeholder="Enter Catogery Description" TextMode="MultiLine" class="form-control mb-2"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <asp:Button runat="server" ID="btnAddCatogery" class="btn btn-primary mb-2" Text="ADD" OnClick="btnAddCatogery_Click" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default mb-2" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Catogery Modal End -->

    <!-- Sub Catogery Modal -->
    <div id="SubCatogeryModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Add Sub Catogery</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <asp:Label runat="server" ID="Label18" for="">Catogery Type</asp:Label>
                            <asp:DropDownList ID="ddlCatogery" class="custom-select form-control-border mb-2" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-12">
                            <asp:Label runat="server" ID="Label19" for="">Sub Catogery Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtSubCatogery" placeholder="Enter Sub Catogery Name" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label20" for="">Sub Catogery Description</asp:Label>
                            <asp:TextBox runat="server" ID="txtSubCatogeryDescription" placeholder="Enter Sub Catogery Description" TextMode="MultiLine" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <asp:Button runat="server" ID="btnAddSubCatogery" class="btn btn-primary mb-2" Text="ADD" OnClick="btnAddSubCatogery_Click" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default mb-2" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Sub Catogery Modal End -->

    <!-- Sub Catogery Modal -->
    <div id="SizeModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Product Size</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label26" for="">Product Size</asp:Label>
                            <asp:TextBox runat="server" ID="TextBox1" placeholder="Enter Product Size" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <asp:Label runat="server" ID="Label25" for="">Size Description</asp:Label>
                            <asp:TextBox runat="server" ID="TextBox2" placeholder="Enter Description Description" TextMode="MultiLine" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <asp:Button runat="server" ID="btnSize" class="btn btn-primary mb-2" Text="ADD" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default mb-2" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Sub Catogery Modal End -->
    <!-- dropzonejs -->
    <script src="plugins/dropzone/dropzone.js"></script>
    <script type="text/javascript">
        const images = document.querySelectorAll('.product-images img');
        const thumbnails = document.querySelectorAll('.thumbnail');

        function changeImage(index) {
            images.forEach((image, i) => {
                if (i === index) {
                    image.classList.add('active');
                } else {
                    image.classList.remove('active');
                }
            });
        }
    </script>
</asp:Content>
