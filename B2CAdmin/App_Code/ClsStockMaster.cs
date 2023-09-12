using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace B2CAdmin.App_Code
{
    public class ClsStockMaster:ClsSqlConnection
    {
        public int AddSizeData(string SizeName, string SizeDescription, int CatogeryId, int CreatedBy)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateSize", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Size", SizeName);
                cmd.Parameters.AddWithValue("@SizeDescription", SizeDescription);
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
        public int AddTaxData(decimal CGST, decimal SGST, decimal IGST, int CreatedBy)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateTax", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CGST", CGST);
                cmd.Parameters.AddWithValue("@SGST", SGST);
                cmd.Parameters.AddWithValue("@IGST", IGST);
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
        public DataTable GetTaxTypeData()
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetTextTypeData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public DataTable GetTaxTypeDataById(int Id)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetTextTypeById", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("Id", Id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public DataTable GetSizeData(int CatogeryId)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetSizeByCatogeryId" , con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CatogeryId", CatogeryId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }

        public int GetCatogeryIdByProductCode(string ProductCode)
        {
            int CatogeryId = 0;
            SqlConnection con = new SqlConnection(SqlCon);
            //string query = "Select * From TblProductMaster where ProductCode=" + ProductCode;
            SqlCommand cmd = new SqlCommand("SP_GetProductSizeByProductCode", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                CatogeryId = Convert.ToInt32(dt.Rows[0]["Catogery"]);
                return CatogeryId;
            }
            else
            {
                return 0;
            }
        }
        public DataTable GetStockData()
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetStockData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public DataTable GetStockDataById(int Id)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetStockDataById" , con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", Id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }


        public int AddStockData(string ProductCode,decimal PurchasePrice, decimal MrpPrice, decimal SalesPrice,int ProductQuantity,int DiscountType, decimal Discount,
            int TaxType, string ProductSize,DateTime MfgDate, DateTime ExpiryDate, int TotalQuantity, int SalesQuantity,
            int AvilableQuantity, int CreateBy, int UpdateBy, string action)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateStockMaster", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
                cmd.Parameters.AddWithValue("@PurchasePrice", PurchasePrice);
                cmd.Parameters.AddWithValue("@MrpPrice", MrpPrice);
                cmd.Parameters.AddWithValue("@SalesPrice", SalesPrice);
                cmd.Parameters.AddWithValue("@ProductQuantity", ProductQuantity);
                cmd.Parameters.AddWithValue("@DiscountType", DiscountType);
                cmd.Parameters.AddWithValue("@Discount", Discount);
                cmd.Parameters.AddWithValue("@TaxType", TaxType);
                cmd.Parameters.AddWithValue("@ProductSize", ProductSize);
                cmd.Parameters.AddWithValue("@MfgDate", MfgDate);
                cmd.Parameters.AddWithValue("@ExpiryDate", ExpiryDate);
                cmd.Parameters.AddWithValue("@TotalQuantity", TotalQuantity);
                cmd.Parameters.AddWithValue("@SalesQuantity", SalesQuantity);
                cmd.Parameters.AddWithValue("@AvilableQuantity", AvilableQuantity);
                cmd.Parameters.AddWithValue("@CreateBy", CreateBy);
                cmd.Parameters.AddWithValue("@UpdateBy", UpdateBy);
                cmd.Parameters.AddWithValue("@action", action);
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
        //public int DeleteStockData(string ProductCode)
        //{
        //    try
        //    {
        //        SqlConnection con = new SqlConnection(SqlCon);
        //        SqlCommand cmd = new SqlCommand("SP_DeleteStockByProductCode", con);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
        //        con.Open();
        //        int result = cmd.ExecuteNonQuery();
        //        return result;
        //    }
        //    catch (Exception)
        //    {
        //        return 0;
        //    }
        //}
    }
}