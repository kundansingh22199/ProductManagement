using B2CAdmin.App_Code;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.SallerModule
{
    public partial class ProductList : System.Web.UI.Page
    {
        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        ClsOrderMaster clsOrder = new ClsOrderMaster();
        int minsize = 10 * 1024; int maxsize = 3 * 1024 * 1024;
        int fileSize1 = 0;
        string fileName1 = "";
        bool status = true;
        int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductLists(0);
                GetValueFromQueryString();
            }
        }
        public void GetValueFromQueryString()
        {
            string idValue = HttpContext.Current.Request.QueryString["StockId"];

            if (!string.IsNullOrEmpty(idValue))
            {
                DataTable dt = clsStock.GetStockDataByStockId(Convert.ToInt32(idValue));
                if (dt.Rows.Count > 0)
                {
                    txtTax.Text = dt.Rows[0]["IGST"].ToString() + " %";
                    string discountType = dt.Rows[0]["DiscountType"].ToString();
                    if (discountType == "1")
                    {
                        txtDiscount.Text = Convert.ToDecimal(dt.Rows[0]["Discount"]).ToString("n2") + " %";
                    }
                    else
                    {
                        txtDiscount.Text = string.Format("{0:n2}", dt.Rows[0]["Discount"]) + " RS";
                    }
                    lblStock.Text = dt.Rows[0]["Id"].ToString();
                    string tax = dt.Rows[0]["TaxType"].ToString();
                    txtPrice.Text = dt.Rows[0]["SalesPrice"].ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowOrderPopup();", true);
                }
            }
            else
            {

            }
        }
        public void ProductLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsProduct.SearchSallerProductByAction(txtSearch.Text.Trim(), ddlSearch.SelectedValue);
                if (dt.Rows.Count > 0 && dt != null)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    pgitems.AllowPaging = true;
                    pgitems.DataSource = dt.DefaultView;
                    pgitems.PageSize = 5;
                    pgitems.CurrentPageIndex = pagenumber;
                    if (pgitems.PageCount > 1)
                    {
                        rptPaging.Visible = true;
                        ArrayList pages = new ArrayList();
                        for (int i = 0; i <= pgitems.PageCount - 1; i++)
                        {
                            pages.Add((i + 1).ToString());
                        }
                        rptPaging.DataSource = pages;
                        rptPaging.DataBind();
                    }
                    else
                    {
                        rptPaging.Visible = false;
                    }
                    Repeater1.DataSource = pgitems;
                    Repeater1.DataBind();
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();
                }
            }
            catch
            {

            }
            finally
            {

            }
        }
        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            ProductLists(pagenumber);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ProductLists(0);
        }
        //public void BindCatogery()
        //{
        //    DataTable dt = clsProduct.GetCtogeryData();
        //    ddlCatogery.DataSource = dt;
        //    ddlCatogery.DataTextField = "CatogeryName";
        //    ddlCatogery.DataValueField = "Id";
        //    ddlCatogery.DataBind();

        //    ListItem selectItem = new ListItem("--Select--", "Selected");
        //    selectItem.Selected = true;
        //    ddlCatogery.Items.Insert(0, selectItem);
        //}
        //public void BindSubCatogery(int catogeryId)
        //{
        //    DataTable dt = clsProduct.GetSubCtogeryData(catogeryId);
        //    ddlSubCatogery.DataSource = dt;
        //    ddlSubCatogery.DataTextField = "SubCatogeryName";
        //    ddlSubCatogery.DataValueField = "Id";
        //    ddlSubCatogery.DataBind();

        //    ListItem selectItem = new ListItem("--Select--", "Selected");
        //    selectItem.Selected = true;
        //    ddlSubCatogery.Items.Insert(0, selectItem);
        //}
        protected void ddlCatogery_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlCatogery.SelectedItem.Text != "--Select--")
            //{
            //    int catogeryId = Convert.ToInt32(ddlCatogery.SelectedValue);
            //    BindSubCatogery(catogeryId);
            //}
            //else
            //{
            //    ddlSubCatogery.SelectedValue = null;
            //    BindSubCatogery(0);
            //}
        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Order")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                DataTable dt = clsStock.GetStockDataByStockId(Convert.ToInt32(txtId.Text.Trim()));
                if (dt.Rows.Count > 0)
                {
                    txtTax.Text = dt.Rows[0]["IGST"].ToString() + " %";
                    string discountType = dt.Rows[0]["DiscountType"].ToString();
                    if (discountType == "1")
                    {
                        txtDiscount.Text = Convert.ToDecimal(dt.Rows[0]["Discount"]).ToString("n2") + " %";
                    }
                    else
                    {
                        txtDiscount.Text = string.Format("{0:n2}", dt.Rows[0]["Discount"]) + " RS";
                    }
                    lblStock.Text = dt.Rows[0]["Id"].ToString();
                    string tax = dt.Rows[0]["TaxType"].ToString();
                    txtPrice.Text = dt.Rows[0]["SalesPrice"].ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowOrderPopup();", true);
                }
            }
            if (e.CommandName == "Image")
            {
                int ProductId = Convert.ToInt32(e.CommandArgument);
                DataTable dt = clsProduct.ProductImageById(ProductId);
                if (dt.Rows.Count > 0)
                {
                    image1.ImageUrl = dt.Rows[0]["ProductImage1"].ToString();
                    image2.ImageUrl = dt.Rows[0]["ProductImage2"].ToString();
                    image3.ImageUrl = dt.Rows[0]["ProductImage3"].ToString();
                    image4.ImageUrl = dt.Rows[0]["ProductImage4"].ToString();
                    image5.ImageUrl = dt.Rows[0]["ProductImage5"].ToString();
                    image6.ImageUrl = dt.Rows[0]["ProductImage6"].ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ImageModel').modal();", true);
                }
            }
        }
        protected void btnOrderProduct_Click(object sender, EventArgs e)
        {
            if (ReceiptUpload.HasFile)
            {
                fileSize1 = ReceiptUpload.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(ReceiptUpload.PostedFile.FileName);
                    ReceiptUpload.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(ReceiptUpload);
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
                fileName1 = "";
            }
            if (status == true && count == 0)
            {
                string OrderBy = Session["UserId"].ToString();
                Random rd = new Random();
                int Quantity = Convert.ToInt32(txtQuantity.Text.Trim());
                string OrderId = rd.Next(1111111, 9999999).ToString();
                decimal Price = Convert.ToDecimal(txtPrice.Text.Trim());
                decimal TotalPrice = Convert.ToDecimal(txtTotalPrice.Text.Trim());
                int result = clsOrder.InsertOrder(OrderId, lblStock.Text.Trim(), Quantity, Price, TotalPrice, ddlPaymentMode.SelectedItem.Text, fileName1, OrderBy);
                if (result > 0)
                {
                    msgsuccess.InnerText = "Order Successfull";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                }
                else
                {
                    msg.InnerText = "Order Not Plessed";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
            }
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

        protected void ddlPaymentMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPaymentMode.SelectedValue == "1")
            {
                lblReceipt.Visible = true;
                lblimage.Visible = true;
            }
            else if(ddlPaymentMode.SelectedValue == "2")
            {
                lblReceipt.Visible = false;
                lblimage.Visible = false;
            }
            else
            {
                lblReceipt.Visible = false;
                lblimage.Visible = false;
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowOrderPopup();", true);
        }
    }
}