using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using B2CAdmin.App_Code;
using System.Drawing;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace B2CAdmin.SallerModule
{
    public partial class SalesPage : System.Web.UI.Page
    {
        ClsStockMaster clsStock = new ClsStockMaster();
        ClsSalesMaster clsSales = new ClsSalesMaster();
        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsUserMaster clsUser = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetSallerStock(0);
            }
        }
        public void GetSallerStock(int pagenumber)
        {
            try
            {
                string userId = Session["UserId"].ToString();
                DataTable dt = clsStock.GetSallerStockListBySalesPriceSearch(userId, txtSearch.Text.Trim(), ddlSearch.SelectedValue);
                if (dt.Rows.Count > 0 && dt != null)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    pgitems.DataSource = dt.DefaultView;
                    pgitems.AllowPaging = true;
                    //control page size from here 
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
            catch (Exception)
            {

            }
        }

        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            GetSallerStock(pagenumber);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Buy")
            {
                ViewState["StockId"] = e.CommandArgument;
                Label lblPrice = e.Item.FindControl("lblSellingPrice") as Label;
                txtPrice.Text = lblPrice.Text;
                Label lblProductCode = e.Item.FindControl("lblProductCode") as Label;
                ViewState["ProductCode"] = lblProductCode.Text;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                ViewState["StockQuantity"] = lblQuantity.Text;
                Label lblProductName = e.Item.FindControl("lblProductName") as Label;
                ViewState["ProductName"] = lblProductName.Text;
                errormsgbox.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ActionModel').modal();", true);
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
            if (e.CommandName == "MultiItemBuy")
            {
                decimal GrandTotal = 0;
                int count = 0;
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[6] { new DataColumn("StockId"), new DataColumn("SellingPrice"), new DataColumn("ProductCode"), new DataColumn("ProductName"), new DataColumn("StockQuantity"), new DataColumn("Quantity") });
                foreach (RepeaterItem item in Repeater1.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        CheckBox checkBox = item.FindControl("CheckSelect") as CheckBox;

                        if (checkBox.Checked)
                        {
                            count++;
                            Label lblStockId = item.FindControl("lblStockId") as Label;
                            Label lblPrice = item.FindControl("lblSellingPrice") as Label;
                            Label lblProductCode = item.FindControl("lblProductCode") as Label;
                            Label lblProductName = item.FindControl("lblProductName") as Label;
                            Label lblQuantity = item.FindControl("lblQuantity") as Label;
                            string Quantity = "1";
                            GrandTotal = GrandTotal + Convert.ToDecimal(lblPrice.Text.Replace(",", ""));
                            dt.Rows.Add(lblStockId.Text, lblPrice.Text, lblProductCode.Text, lblProductName.Text, lblQuantity.Text, Quantity);
                        }
                    }
                }
                if (count > 0)
                {
                    txtGrandTotal.Text = GrandTotal.ToString();
                    repBuyProduct.DataSource = dt;
                    repBuyProduct.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#MultiItemSelectModel').modal();", true);
                }
                else
                {
                    errormsg.InnerText = "Select At least One Product";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataTable dtPrint = new DataTable();
            dtPrint.Columns.AddRange(new DataColumn[7] { new DataColumn("CustomerMobile"), new DataColumn("ProductCode"), new DataColumn("ProductName"), new DataColumn("Quantity"), new DataColumn("Price"), new DataColumn("TotalPrice"), new DataColumn("Status") });
            string UserId = Session["UserId"].ToString();
            int count = 0;
            int Quantity = Convert.ToInt32(txtQuantity.Text.Trim());
            decimal Price = Convert.ToDecimal(txtPrice.Text.Trim().Replace(",", ""));
            decimal TotalPrice = Price * Quantity;
            string StockId = ViewState["StockId"].ToString();
            string ProductCode = ViewState["ProductCode"].ToString();
            int StockQuantity = Convert.ToInt32(ViewState["StockQuantity"]);
            string ProductName = ViewState["ProductName"].ToString();
            if (txtMobileNo.Text.Trim() != "" && txtName.Text.Trim() != "")
            {
                if (StockQuantity > Quantity)
                {
                    count = clsSales.CheckDuplicateCustomer(txtMobileNo.Text.Trim());
                    string Status = "1";
                    if (count > 0)
                    {
                        int result = clsSales.BuyProduct(txtMobileNo.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                        if (result > 0)
                        {
                            GetSallerStock(0);
                            errormsgbox.Visible = false;
                            dtPrint.Rows.Add(txtCustomerMobile.Text.Trim(), ProductCode, ProductName, Quantity, Price, TotalPrice, "Success");
                            //msgsuccess.InnerText = "Order Successfull";
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                        }
                        else
                        {
                            errormsgbox.Visible = false;
                            errormsg.InnerText = "Somthing Wrong";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                        }
                    }
                    else
                    {
                        int result1 = clsSales.InsertCustomer(txtMobileNo.Text.Trim(), txtName.Text.Trim(), txtMobileNo.Text.Trim(), Status, UserId);
                        int result2 = clsSales.BuyProduct(txtMobileNo.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                        if (result2 > 0 && result1 > 0)
                        {
                            GetSallerStock(0);
                            errormsgbox.Visible = false;
                            dtPrint.Rows.Add(txtMobileNo.Text.Trim(), ProductCode, ProductName, Quantity, Price, TotalPrice, "Success");
                            //msgsuccess.InnerText = "Order Successfull";
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                        }
                        else
                        {
                            errormsg.InnerText = "Somthing Wrong";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                        }
                    }
                }
                else
                {
                    errormsg.InnerText = "Low Stock";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
                txtGrandTotalPrint.Text = "Grand Total : " + TotalPrice;
                lblCustomerName.Text = "Mr/Mrs. " + txtName.Text;
                lblCustomerMobileNo.Text = "+91-" + txtMobileNo.Text;
                DataTable dt = clsUser.UserDetailsById(Convert.ToInt32(UserId));
                lblCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
                lblAddress.Text = dt.Rows[0]["Address"].ToString();
                lblSellerName.Text = dt.Rows[0]["UserName"].ToString();
                lblSellerMobile.Text = "+91-" + dt.Rows[0]["MobileNo"].ToString();
                RepOrderPrint.DataSource = dtPrint;
                RepOrderPrint.DataBind();
                errormsgbox.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#OrderPrintModel').modal();", true);
            }
            else
            {
                errormsgbox.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ActionModel').modal();", true);
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetSallerStock(0);
        }

        protected void btnbuyAll_Click(object sender, EventArgs e)
        {
            string UserId = Session["UserId"].ToString();
            DataTable dtPrint = new DataTable();
            dtPrint.Columns.AddRange(new DataColumn[7] { new DataColumn("CustomerMobile"), new DataColumn("ProductCode"), new DataColumn("ProductName"), new DataColumn("Quantity"), new DataColumn("Price"), new DataColumn("TotalPrice"), new DataColumn("Status") });
            foreach (RepeaterItem item in repBuyProduct.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    messageboxerror.Visible = false;
                    Label lblStockId = item.FindControl("lblStockId") as Label;
                    Label lblSellingPrice = item.FindControl("lblSellingPrice") as Label;
                    Label lblProductCode = item.FindControl("lblProductCode") as Label;
                    Label lblProductName = item.FindControl("lblProductName") as Label;
                    Label lblQuantity = item.FindControl("lblQuantity") as Label;
                    Label lblStockQuantity = item.FindControl("lblStockQuantity") as Label;



                    
                    int count = 0;
                    int Quantity = Convert.ToInt32(lblQuantity.Text.Trim());
                    decimal Price = Convert.ToDecimal(lblSellingPrice.Text.Trim().Replace(",", ""));
                    decimal TotalPrice = Price * Quantity;
                    string StockId = lblStockId.Text;
                    string ProductCode = lblProductCode.Text;
                    int StockQuantity = Convert.ToInt32(lblStockQuantity.Text);
                    if (StockQuantity >= Quantity)
                    {
                        if (txtCustomerMobile.Text.Trim() != "" && txtCustomerName.Text.Trim() !="")
                        {
                            count = clsSales.CheckDuplicateCustomer(txtCustomerMobile.Text.Trim());
                            string Status = "1";
                            if (count > 0)
                            {
                                int result = clsSales.BuyProduct(txtCustomerMobile.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                                if (result > 0)
                                {
                                    messageboxerror.Visible = false;
                                    dtPrint.Rows.Add(txtCustomerMobile.Text.Trim(), ProductCode, lblProductName.Text.Trim(), Quantity, Price, TotalPrice, "Success");
                                    GetSallerStock(0);
                                }
                            }
                            else
                            {
                                int result1 = clsSales.InsertCustomer(txtCustomerMobile.Text.Trim(), txtCustomerName.Text.Trim(), txtCustomerMobile.Text.Trim(), Status, UserId);
                                int result2 = clsSales.BuyProduct(txtCustomerMobile.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                                if (result2 > 0)
                                {
                                    messageboxerror.Visible = false;
                                    dtPrint.Rows.Add(txtCustomerMobile.Text.Trim(), ProductCode, lblProductName.Text.Trim(), Quantity, Price, TotalPrice, "Success");
                                    GetSallerStock(0);
                                }
                            }
                            messageboxerror.Visible = false;
                        }
                        else
                        {
                            messageboxerror.Visible = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#MultiItemSelectModel').modal();", true);
                        }
                    }
                    else
                    {
                        messageboxerror.Visible = false;
                        dtPrint.Rows.Add(txtCustomerMobile.Text.Trim(), ProductCode, lblProductName.Text.Trim(), Quantity, Price, TotalPrice, "Out of Stock");
                    }
                }
            }
            txtGrandTotalPrint.Text = "Grand Total : "+txtGrandTotal.Text;
            lblCustomerName.Text = "Mr/Mrs. " + txtCustomerName.Text;
            lblCustomerMobileNo.Text = "+91-" + txtCustomerMobile.Text;
            DataTable dt = clsUser.UserDetailsById(Convert.ToInt32(UserId));
            lblCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
            lblAddress.Text = dt.Rows[0]["Address"].ToString();
            lblSellerName.Text = dt.Rows[0]["UserName"].ToString();
            lblSellerMobile.Text = "+91-" + dt.Rows[0]["MobileNo"].ToString();
            RepOrderPrint.DataSource = dtPrint;
            RepOrderPrint.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#OrderPrintModel').modal();", true);
        }

        protected void repBuyProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            decimal GrandTotal = Convert.ToDecimal(txtGrandTotal.Text.Trim());
            Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
            int Quantity = Convert.ToInt32(lblQuantity.Text.Trim());
            Label lblStockQuantity = e.Item.FindControl("lblStockQuantity") as Label;
            int StockQuantity = Convert.ToInt32(lblStockQuantity.Text.Trim());

            Label lblSellingPrice = e.Item.FindControl("lblSellingPrice") as Label;
            decimal SellingPrice = Convert.ToDecimal(lblSellingPrice.Text.Trim().Replace(",", ""));
            Label lblTotalPrice = e.Item.FindControl("lblTotalPrice") as Label;
            decimal TotalPrice = Convert.ToDecimal(lblTotalPrice.Text.Trim().Replace(",",""));
            if (e.CommandName== "QuantityPlus")
            {
                if (StockQuantity > Quantity)
                {
                    int NewQuantity = (Quantity + 1);
                    lblQuantity.Text = NewQuantity.ToString();
                    lblTotalPrice.Text = (NewQuantity* SellingPrice).ToString();
                    txtGrandTotal.Text = (GrandTotal + SellingPrice).ToString();

                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#MultiItemSelectModel').modal();", true);
            }
            if (e.CommandName == "QuantityMinus")
            {
                if (Quantity > 1)
                {
                    int NewQuantity = (Quantity - 1);
                    lblQuantity.Text = NewQuantity.ToString();
                    lblTotalPrice.Text = (NewQuantity * SellingPrice).ToString();
                    txtGrandTotal.Text = (GrandTotal - SellingPrice).ToString();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#MultiItemSelectModel').modal();", true);
            }
        }

        protected void repBuyProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
           
        }
        protected void btnPrintOrder_Click(object sender, EventArgs e)
        {
            btnPrintOrder.Visible = false;
            modelFooter.Visible = false;
            btnclose.Visible = false;

            StringWriter stringWrite = new StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            Page pg = new Page();
            HtmlForm frm = new HtmlForm();
            pg.Controls.Add(frm);
            frm.Attributes.Add("runat", "server");
            frm.Controls.Add(DivModelPrint);

            pg.RenderControl(htmlWrite);
            string strHTML = stringWrite.ToString();

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "text/html"; // Set the content type to HTML
            HttpContext.Current.Response.Write("<html><head><title>Print</title></head><body>");
            HttpContext.Current.Response.Write(strHTML);
            HttpContext.Current.Response.Write("</body></html>");
            HttpContext.Current.Response.Write("<script>window.print();</script>");
            HttpContext.Current.Response.End();
        }
    }
}