using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin.AdminModule
{
    public partial class AddProduct : System.Web.UI.Page
    {
        ClsProductMaster clsProduct = new ClsProductMaster();
        int minsize = 20 * 1024; int maxsize = 5 * 1024 * 1024;
        int fileSize1 = 0, fileSize2 = 0, fileSize3 = 0, fileSize4 = 0, fileSize5 = 0, fileSize6 = 0;
        string fileName1 = "", fileName2 = "", fileName3 = "", fileName4 = "", fileName5 = "", fileName6 = "";
        bool status = true;
        int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCatogery();
                GetValueFromQueryString();
            }
        }
        public void GetValueFromQueryString()
        {
            string idValue = HttpContext.Current.Request.QueryString["Id"];

            if (!string.IsNullOrEmpty(idValue))
            {
                int Id = Convert.ToInt32(idValue);
                DataTable dt = clsProduct.ProductListDetailsById(Id);
                if (dt.Rows.Count > 0 )
                {
                    txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                    txtSerialNo.Text = dt.Rows[0]["SerialNo"].ToString();
                    ddlProductCatogery.SelectedValue = dt.Rows[0]["Catogery"].ToString();
                    BindSubCatogery();
                    ddlProductSubCatogery.SelectedValue = dt.Rows[0]["SubCatogery"].ToString();
                    txtHsnCode.Text = dt.Rows[0]["HSNCode"].ToString();
                    txtBarCode.Text = dt.Rows[0]["BarCode"].ToString();
                    txtProductDetails.Text = dt.Rows[0]["ProductDetails"].ToString();
                    txtOtherDetails.Text = dt.Rows[0]["OtherDetails"].ToString();

                    ViewState["ProductCode"] = dt.Rows[0]["ProductCode"].ToString();

                    ViewState["ProductImage1"] = dt.Rows[0]["ProductImage1"].ToString();
                    ViewState["ProductImage2"] = dt.Rows[0]["ProductImage2"].ToString();
                    ViewState["ProductImage3"] = dt.Rows[0]["ProductImage3"].ToString();
                    ViewState["ProductImage4"] = dt.Rows[0]["ProductImage4"].ToString();
                    ViewState["ProductImage5"] = dt.Rows[0]["ProductImage5"].ToString();
                    ViewState["ProductImage6"] = dt.Rows[0]["ProductImage6"].ToString();

                    //ProductImage1.ImageUrl = dt1.Rows[0]["ProductImage1"].ToString();
                    //ProductImage2.ImageUrl = dt1.Rows[0]["ProductImage2"].ToString();
                    //ProductImage3.ImageUrl = dt1.Rows[0]["ProductImage3"].ToString();
                    //ProductImage4.ImageUrl = dt1.Rows[0]["ProductImage4"].ToString();
                    //ProductImage5.ImageUrl = dt1.Rows[0]["ProductImage5"].ToString();
                    //ProductImage6.ImageUrl = dt1.Rows[0]["ProductImage6"].ToString();

                    btnUpdate.Visible = true;
                    btnSubmit.Visible = false;
                }
            }
            else
            {
                btnUpdate.Visible = false;
                btnSubmit.Visible = true;
            }
        }
        protected void btnAddCatogery_Click(object sender, EventArgs e)
        {
            int userid = Convert.ToInt32(Session["UserId"]);
            int result = 0;
            result = clsProduct.AddCatogery(txtAddCatogery.Text,txtCatogeryDescription.Text, userid);
            if (result > 0)
            {
                BindCatogery();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Yah!!', 'Catogery Added ', 'Sucess')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
            }
        }
        public void BindCatogery()
        {
            DataTable dt = clsProduct.GetCtogeryData();
            ddlProductCatogery.DataSource = dt;
            ddlProductCatogery.DataTextField = "CatogeryName";
            ddlProductCatogery.DataValueField = "Id";
            ddlProductCatogery.DataBind();

            ddlCatogery.DataSource = dt;
            ddlCatogery.DataTextField = "CatogeryName";
            ddlCatogery.DataValueField = "Id";
            ddlCatogery.DataBind();

            ListItem selectItem = new ListItem("--Select--", "Selected");
            selectItem.Selected = true;
            ddlProductCatogery.Items.Insert(0, selectItem);
            ddlCatogery.Items.Insert(0, selectItem);
        }
        protected void btnAddSubCatogery_Click(object sender, EventArgs e)
        {
            int result = 0;
            int catogeryId = Convert.ToInt32(ddlCatogery.SelectedValue);
            int userid = Convert.ToInt32(Session["UserId"]);
            result = clsProduct.AddSubCatogery(txtSubCatogery.Text, txtSubCatogeryDescription.Text, catogeryId, userid);
            if (result > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Yah!!', 'Sub Catogery Added ', 'Sucess')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
            }
        }
        protected void btnStock_Click(object sender, EventArgs e)
        {
            string productCode = ViewState["ProductCode"].ToString();
            Response.Redirect("StockManagement.aspx?ProductCode=" + productCode + "");
        }
        protected void ddlProductCatogery_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProductCatogery.SelectedValue == "Selected")
            {
                ddlProductSubCatogery.SelectedValue = null;
            }
            else
            {
                int CatogeryId = Convert.ToInt32(ddlProductCatogery.SelectedValue);
                clsProduct.GetSubCtogeryData(CatogeryId);
                BindSubCatogery();
            }
            
        }
        public void BindSubCatogery()
        {
            int catogeryId = Convert.ToInt32(ddlProductCatogery.SelectedValue);
            DataTable dt = clsProduct.GetSubCtogeryData(catogeryId);
            ddlProductSubCatogery.DataSource = dt;
            ddlProductSubCatogery.DataTextField = "SubCatogeryName";
            ddlProductSubCatogery.DataValueField = "Id";
            ddlProductSubCatogery.DataBind();

            ListItem selectItem = new ListItem("--Select--", "Selected");
            selectItem.Selected = true;
            ddlProductSubCatogery.Items.Insert(0, selectItem);
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (imgupload1.HasFile)
            {
                fileSize1 = imgupload1.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(imgupload1.PostedFile.FileName);
                    string UserImg = Server.MapPath("~/Images/");
                    imgupload1.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(imgupload1);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                count++;
            }
            if (imgupload2.HasFile)
            {
                fileSize2 = imgupload2.PostedFile.ContentLength;
                if (fileSize2 > minsize & fileSize2 < maxsize)
                {
                    fileName2 = Path.GetFileName(imgupload2.PostedFile.FileName);
                    imgupload2.SaveAs(Server.MapPath("~/Images/" + fileName2));
                    fileName2 = "~/Images/" + fileName2;
                    status = checkexetion(imgupload2);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                count++;
            }
            if (imgupload3.HasFile)
            {
                fileSize3 = imgupload3.PostedFile.ContentLength;
                if (fileSize3 > minsize & fileSize3 < maxsize)
                {
                    fileName3 = Path.GetFileName(imgupload3.PostedFile.FileName);
                    imgupload3.SaveAs(Server.MapPath("~/Images/" + fileName3));
                    fileName3 = "~/Images/" + fileName3;
                    status = checkexetion(imgupload3);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName3 = "";
            }
            if (imgupload4.HasFile)
            {
                fileSize4 = imgupload4.PostedFile.ContentLength;
                if (fileSize4 > minsize & fileSize4 < maxsize)
                {
                    fileName4 = Path.GetFileName(imgupload4.PostedFile.FileName);
                    imgupload4.SaveAs(Server.MapPath("~/Images/" + fileName4));
                    fileName4 = "~/Images/" + fileName4;
                    status = checkexetion(imgupload4);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName4 = "";
            }
            if (imgupload5.HasFile)
            {
                fileSize5 = imgupload5.PostedFile.ContentLength;
                if (fileSize5 > minsize & fileSize5 < maxsize)
                {
                    fileName5 = Path.GetFileName(imgupload5.PostedFile.FileName);
                    imgupload5.SaveAs(Server.MapPath("~/Images/" + fileName5));
                    fileName5 = "~/Images/" + fileName5;
                    status = checkexetion(imgupload5);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName5 = "";
            }
            if (imgupload6.HasFile)
            {
                fileSize6 = imgupload6.PostedFile.ContentLength;
                if (fileSize6 > minsize & fileSize6 < maxsize)
                {
                    fileName6 = Path.GetFileName(imgupload6.PostedFile.FileName);
                    imgupload6.SaveAs(Server.MapPath("~/Images/" + fileName6));
                    fileName6 = "~/Images/" + fileName6;
                    status = checkexetion(imgupload6);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName6 = "";
            }

            if (status==true && count==0)
            {
                Random random = new Random();
                string productCode = "WTS" + DateTime.Now.ToString("ddMMyyyy") + random.Next(1111, 9999).ToString();
                int result = 0;
                int userid = Convert.ToInt32(Session["UserId"]);
                string otherDetails = txtOtherDetails.Text.Trim();
                if(otherDetails=="" || otherDetails == null)
                {
                    otherDetails = "";
                }
                string Action = "Insert";
                result = clsProduct.AddProductData(productCode, txtProductName.Text.Trim(), ddlProductCatogery.SelectedValue, ddlProductSubCatogery.SelectedValue,
                    txtHsnCode.Text.Trim(), txtProductDetails.Text.Trim(), txtBarCode.Text.Trim(),
                    txtSerialNo.Text.Trim(), otherDetails, userid, Action);

                int ProductId = clsProduct.ProductListDetailsByProductCode(productCode);
                if (result > 0)
                {
                    int result2 = clsProduct.AddProductImage(ProductId, fileName1, fileName2, fileName3, fileName4, fileName5, fileName6, userid,Action);
                    if (result2 > 0)
                    {
                        messagebox.Visible = true;
                        messageboxerror.Visible = false;
                        txtmess.InnerText = "\t Product Code : " + productCode;
                        Clear();
                        btnStock.Visible = true;
                        ViewState["ProductCode"] = productCode;
                    }
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    btnStock.Visible = false;
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
                btnStock.Visible = false;
            }
        }

        public void GetProductCode()
        {
            Random random = new Random();
            string productCode = "WTS"+DateTime.Now.ToString("ddMMyyyy") + random.Next(1111, 9999).ToString();
            //txtProdectCode.Text = productCode;
        }
        public bool checkexetion(FileUpload FileUpl)
        {
            try
            {
                bool Status;

                string FileExt = Path.GetExtension(FileUpl.FileName);
                if (FileExt.ToUpper() == "PNG" || FileExt.ToUpper() == "JPG" || FileExt.ToUpper() == "JPEG" || FileExt.ToUpper() == ".JPEG" || FileExt.ToUpper() == ".JPG" || FileExt.ToUpper() == ".PNG")
                {
                    Status = true;
                }
                else
                {
                    Status = false;
                }

                return Status;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        protected void btnProductCode_Click(object sender, EventArgs e)
        {
            GetProductCode();
        }
        public void Clear()
        {
            txtProductName.Text = txtSerialNo.Text = txtHsnCode.Text = txtBarCode.Text = txtProductDetails.Text = txtOtherDetails.Text = "";
            ddlProductCatogery.SelectedValue = ddlProductSubCatogery.SelectedValue = null;
            imgupload1.Dispose();
            imgupload2.Dispose();
            imgupload3.Dispose();
            imgupload4.Dispose();
            imgupload5.Dispose();
            imgupload6.Dispose();
        }

        public void generateBarcode()
        {
            //BarcodeWriter barcodeWriter = new BarcodeWriter();
            //barcodeWriter.Format = BarcodeFormat.QR_CODE;

            //// Set optional parameters like width and height
            //barcodeWriter.Options = new ZXing.Common.EncodingOptions
            //{
            //    Width = 300,
            //    Height = 300
            //};

            //// Generate the barcode data
            //string barcodeData = "Hello, World!"; // Your data here

            //// Encode the data into a barcode image
            //Bitmap barcodeBitmap = barcodeWriter.Write(barcodeData);

            //// Save the barcode image to a file
            //string fileName = "barcode.png"; // You can change the file name and format as needed
            //barcodeBitmap.Save(fileName);

            //Console.WriteLine($"Barcode saved as {fileName}");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (imgupload1.HasFile)
            {
                fileSize1 = imgupload1.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(imgupload1.PostedFile.FileName);
                    imgupload1.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(imgupload1);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName1= ViewState["ProductImage1"].ToString();
            }
            if (imgupload2.HasFile)
            {
                fileSize2 = imgupload2.PostedFile.ContentLength;
                if (fileSize2 > minsize & fileSize2 < maxsize)
                {
                    fileName2 = Path.GetFileName(imgupload2.PostedFile.FileName);
                    imgupload2.SaveAs(Server.MapPath("~/Images/" + fileName2));
                    fileName2 = "~/Images/" + fileName2;
                    status = checkexetion(imgupload2);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName2 = ViewState["ProductImage2"].ToString();
            }
            if (imgupload3.HasFile)
            {
                fileSize3 = imgupload3.PostedFile.ContentLength;
                if (fileSize3 > minsize & fileSize3 < maxsize)
                {
                    fileName3 = Path.GetFileName(imgupload3.PostedFile.FileName);
                    imgupload3.SaveAs(Server.MapPath("~/Images/" + fileName3));
                    fileName3 = "~/Images/" + fileName3;
                    status = checkexetion(imgupload3);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName3 = ViewState["ProductImage3"].ToString();
            }
            if (imgupload4.HasFile)
            {
                fileSize4 = imgupload4.PostedFile.ContentLength;
                if (fileSize4 > minsize & fileSize4 < maxsize)
                {
                    fileName4 = Path.GetFileName(imgupload4.PostedFile.FileName);
                    imgupload4.SaveAs(Server.MapPath("~/Images/" + fileName4));
                    fileName4 = "~/Images/" + fileName4;
                    status = checkexetion(imgupload4);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName4 = ViewState["ProductImage4"].ToString();
            }
            if (imgupload5.HasFile)
            {
                fileSize5 = imgupload5.PostedFile.ContentLength;
                if (fileSize5 > minsize & fileSize5 < maxsize)
                {
                    fileName5 = Path.GetFileName(imgupload5.PostedFile.FileName);
                    imgupload5.SaveAs(Server.MapPath("~/Images/" + fileName5));
                    fileName5 = "~/Images/" + fileName5;
                    status = checkexetion(imgupload5);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName5 = ViewState["ProductImage5"].ToString();
            }
            if (imgupload6.HasFile)
            {
                fileSize6 = imgupload6.PostedFile.ContentLength;
                if (fileSize6 > minsize & fileSize6 < maxsize)
                {
                    fileName6 = Path.GetFileName(imgupload6.PostedFile.FileName);
                    imgupload6.SaveAs(Server.MapPath("~/Images/" + fileName6));
                    fileName6 = "~/Images/" + fileName6;
                    status = checkexetion(imgupload6);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName6 = ViewState["ProductImage6"].ToString();
            }
            if (status == true && count == 0)
            {
                string productCode = ViewState["ProductCode"].ToString();
                int result = 0;
                string otherDetails = txtOtherDetails.Text.Trim();
                if (otherDetails == "" || otherDetails == null)
                {
                    otherDetails = "";
                }
                int userid = Convert.ToInt32(Session["UserId"]);
                string Action = "Update";
                result = clsProduct.AddProductData(productCode, txtProductName.Text.Trim(), ddlProductCatogery.SelectedValue, ddlProductSubCatogery.SelectedValue,
                    txtHsnCode.Text.Trim(), txtProductDetails.Text.Trim(), txtBarCode.Text.Trim(),
                    txtSerialNo.Text.Trim(), otherDetails, userid, Action);

                int ProductId = clsProduct.ProductListDetailsByProductCode(productCode);
                if (result > 0)
                {
                    int result2 = clsProduct.AddProductImage(ProductId, fileName1, fileName2, fileName3, fileName4, fileName5, fileName6, userid, Action);
                    if (result2 > 0)
                    {
                        messagebox.Visible = true;
                        messageboxerror.Visible = false;
                        txtmess.InnerText = "\t Product Update sucessfull ";
                        Clear();
                    }
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
            }
        }
    }
}