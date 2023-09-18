using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;
using OfficeOpenXml;

namespace B2CAdmin.AdminModule
{

    public partial class ProductList : System.Web.UI.Page
    {
        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductLists(0);
            }
        }
       
        public void ProductLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsProduct.ProductListDetails();
                
                Repeater2.DataSource = dt;
                Repeater2.DataBind();
                if (dt.Rows.Count > 0)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    if (txtSearch.Text.Trim() == "")
                    {
                        pgitems.DataSource = dt.DefaultView;
                        pgitems.AllowPaging = true;
                    }
                    else
                    {
                        DataTable dt1 = clsProduct.SearchProductBySearchText(txtSearch.Text.Trim());
                        pgitems.DataSource = dt1.DefaultView;
                        pgitems.AllowPaging = true;
                    }

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

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Label lblId = (Label)e.Item.FindControl("lblId");
            int Id = Convert.ToInt32(lblId.Text);
            DataTable dt = clsProduct.ProductListDetailsById(Id);
            //int ProductId = clsProduct.ProductListDetailsByProductCode(dt.Rows[0]["ProductCode"].ToString());
            //DataTable dt1 = clsProduct.ProductImage(ProductId);
            if (e.CommandName == "Details")
            {
                lblProductId.Text = dt.Rows[0]["Id"].ToString();
                lblProductCode.Text = dt.Rows[0]["ProductCode"].ToString();
                lblProductName.Text = dt.Rows[0]["ProductName"].ToString();
                lblCatogery.Text = dt.Rows[0]["CatogeryName"].ToString();
                lblSubCatogery.Text = dt.Rows[0]["SubCatogeryName"].ToString();
                lblHsnCode.Text = dt.Rows[0]["HSNCode"].ToString();
                lblProductDetails.Text = dt.Rows[0]["ProductDetails"].ToString();
                lblBarCode.Text = dt.Rows[0]["BarCode"].ToString();
                lblSerialNo.Text = dt.Rows[0]["SerialNo"].ToString();
                lblOtherDetails.Text = dt.Rows[0]["OtherDetails"].ToString();
                //lblCreateDate.Text = dt.Rows[0]["CreateOn"].ToString();


                image1.ImageUrl = dt.Rows[0]["ProductImage1"].ToString();
                image2.ImageUrl = dt.Rows[0]["ProductImage2"].ToString();
                image3.ImageUrl = dt.Rows[0]["ProductImage3"].ToString();
                image4.ImageUrl = dt.Rows[0]["ProductImage4"].ToString();
                image5.ImageUrl = dt.Rows[0]["ProductImage5"].ToString();
                image6.ImageUrl = dt.Rows[0]["ProductImage6"].ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup();", true);
            }
            if (e.CommandName == "Update")
            {
                Response.Redirect("AddProduct.aspx?Id=" + Id + "");
            }
            if (e.CommandName == "Delete")
            {
                int result = clsProduct.DeleteProductData(Id);
                if (result > 0)
                {
                    ProductLists(0);
                }
                else
                {

                }
            }
            if (e.CommandName == "Stock")
            {
                string ProductCode = dt.Rows[0]["ProductCode"].ToString();
                Response.Redirect("StockManagement.aspx?ProductCode=" + ProductCode + "");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            btn_close.Visible = false;
            btnPrint.Visible = false;
            Btn_back.Visible = false;
            StringWriter stringWrite = new StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            Page pg = new Page();
            //pg.EnableEventValidation = false;
            HtmlForm frm = new HtmlForm();
            //pg.EnableEventValidation = false;
            pg.Controls.Add(frm);
            frm.Attributes.Add("runat", "server");
            frm.Controls.Add(divmodel);
            pg.DesignerInitialize();
            pg.RenderControl(htmlWrite);
            string strHTML = stringWrite.ToString();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(strHTML);
            HttpContext.Current.Response.Write("<script>window.print();</script>");
            HttpContext.Current.Response.End();
        }

        protected void Btn_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductList.aspx");
        }

        protected void btnExportInExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=RepeaterExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Repeater2.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ProductLists(0);
        }
    }
}