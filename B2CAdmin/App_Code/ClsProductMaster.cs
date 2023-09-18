using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace B2CAdmin.App_Code
{
    public class ClsProductMaster:ClsSqlConnection
    {
        public int AddProductData(string ProductCode,string ProductName,string Catogery,string SubCatogery,string HSNCode,
            string ProductDetails,string BarCode, string SerialNo,string OtherDetails, int CreateBy,string Action)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
                cmd.Parameters.AddWithValue("@ProductName", ProductName);
                cmd.Parameters.AddWithValue("@Catogery", Catogery);
                cmd.Parameters.AddWithValue("@SubCatogery", SubCatogery);
                cmd.Parameters.AddWithValue("@HSNCode", HSNCode);
                cmd.Parameters.AddWithValue("@ProductDetails", ProductDetails);
                cmd.Parameters.AddWithValue("@BarCode", BarCode);
                cmd.Parameters.AddWithValue("@SerialNo", SerialNo);
                cmd.Parameters.AddWithValue("@OtherDetails", OtherDetails);
                cmd.Parameters.AddWithValue("@CreateBy", CreateBy);
                cmd.Parameters.AddWithValue("@Action", Action);
                cmd.Parameters.AddWithValue("@UpdateBy", "");
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public DataTable GetCtogeryData()
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetCatogeryData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public int AddCatogery(string CatogeryName, string CatogeryDescription, int CreatedBy)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateCatogery", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CatogeryName", CatogeryName);
                cmd.Parameters.AddWithValue("@CatogeryDescription", CatogeryDescription);
                cmd.Parameters.AddWithValue("@CreateBy", CreatedBy);
                cmd.Parameters.AddWithValue("@Action", "Insert");
                cmd.Parameters.AddWithValue("@Id", "");
                cmd.Parameters.AddWithValue("@UpdateBy", "");
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }

        }

        public int AddProductImage(int ProductId, string ProductImage1, string ProductImage2, string ProductImage3, string ProductImage4, string ProductImage5, string ProductImage6, int CreatedBy,string Action)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_ImageInsertUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductId", ProductId);
                cmd.Parameters.AddWithValue("@ProductImage1", ProductImage1);
                cmd.Parameters.AddWithValue("@ProductImage2", ProductImage2);
                cmd.Parameters.AddWithValue("@ProductImage3", ProductImage3);
                cmd.Parameters.AddWithValue("@ProductImage4", ProductImage4);
                cmd.Parameters.AddWithValue("@ProductImage5", ProductImage5);
                cmd.Parameters.AddWithValue("@ProductImage6", ProductImage6);
                cmd.Parameters.AddWithValue("@CreateBy", CreatedBy);
                cmd.Parameters.AddWithValue("@Action", Action);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }

        }
        public int AddSubCatogery(string SubCatogeryName, string SubCatogeryDescription, int CatogeryId, int CreatedBy)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateSubCatogery", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SubCatogeryName", SubCatogeryName);
                cmd.Parameters.AddWithValue("@SubCatogeryDescription", SubCatogeryDescription);
                cmd.Parameters.AddWithValue("@CatogeryId", CatogeryId);
                cmd.Parameters.AddWithValue("@CreateBy", CreatedBy);
                cmd.Parameters.AddWithValue("@Action", "Insert");
                cmd.Parameters.AddWithValue("@Id", "");
                cmd.Parameters.AddWithValue("@UpdateBy", "");
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public DataTable GetSubCtogeryData(int CatogeryId)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetSubCatogeryDataByCatogeryId", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CatogeryId", CatogeryId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public DataTable ProductListDetails()
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetProductListData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public DataTable ProductListDetailsById(int Id)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetProductListDetailsById", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", Id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        //public DataTable ProductImage(int Id)
        //{
        //    SqlConnection con = new SqlConnection(SqlCon);
        //    SqlCommand cmd = new SqlCommand("Select * From TblImageMaster where ProductId=" + Id, con);
        //    SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    sda.Fill(dt);
        //    return dt;
        //}

        public int DeleteProductData(int Id)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_DeleteStockProductAndImageByProductCode", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int ProductListDetailsByProductCode(string ProductCode)
        {
            int ProductId = 0;
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetProductIdByProductCode", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ProductId = Convert.ToInt32(dt.Rows[0]["Id"]);
                return ProductId;
            }
            else
            {
                return 0;
            }
        }
        public DataTable SearchProductBySearchText(string SearchText )
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_SearchProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SearchData", SearchText);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
    }
}