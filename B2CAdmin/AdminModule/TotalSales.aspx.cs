using B2CAdmin.App_Code;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.AdminModule
{
    public partial class TotalSales : System.Web.UI.Page
    {
        ClsSalesMaster clsSales = new ClsSalesMaster();
        ClsProductMaster clsProduct = new ClsProductMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSalesLists(0);
            }
        }
        public void BindSalesLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsSales.GetTotalSalesList(txtfromDate.Text.Trim(), txtoDate.Text.Trim(), txtsearch.Text.Trim(), ddlSearch.SelectedValue);
                if (dt != null && dt.Rows.Count > 0)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    pgitems.DataSource = dt.DefaultView;
                    pgitems.AllowPaging = true;
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
            catch (Exception ex)
            {

            }
        }
        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            BindSalesLists(pagenumber);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindSalesLists(0);
        }
        protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSearch.SelectedValue == "ByDate")
            {
                txtsearch.Text = "";
                divDate1.Visible = true;
                divDate2.Visible = true;
                divText.Visible = false;
            }
            else
            {
                txtfromDate.Text = "";
                txtoDate.Text = "";
                divDate1.Visible = false;
                divDate2.Visible = false;
                divText.Visible = true;
            }
        }
    }
}