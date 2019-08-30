using System;
using System.Web;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace Superexpert
{

    public class VirtualFiles
    {

        static readonly string _connectionString;

        /// <summary>
        /// Get the connection string from Web.Config
        /// </summary>
        static VirtualFiles()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["VirtualFiles"].ConnectionString;
        }


        public static int GetCodeSampleId(string virtualPath)
        {
            string[] segments = virtualPath.Split('/');
            return Int32.Parse(segments[segments.Length - 2]);
        }

        /// <summary>
        /// Check if file exists in database
        /// </summary>
        public static bool FileExists(string virtualPath)
        {
            int codeSampleId = GetCodeSampleId(virtualPath);
            return (CodeSample.Get(codeSampleId).Id != 0);
        }


        /// <summary>
        /// Returns a single virtual file
        /// </summary>
        public static SqlVirtualFile FileSelect(string virtualPath)
        {
            return new SqlVirtualFile(virtualPath);
        }


        /// <summary>
        /// Add new file to database
        /// </summary>
        public static void FileInsert(string virtualPath, string name, string content)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "INSERT VirtualFiles (Path,Name,Content) VALUES (@Path,@Name,@Content)";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Content", content);

            // Execute command
            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        /// <summary>
        /// Deletes a file from the database
        /// </summary>
        public static void FileDelete(string virtualPath)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Break virtualPath
            string path = VirtualPathUtility.GetDirectory(virtualPath);
            string fileName = VirtualPathUtility.GetFileName(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "DELETE VirtualFiles WHERE Path=@Path AND Name=@Name";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameters
            cmd.Parameters.AddWithValue("@Path", path);
            cmd.Parameters.AddWithValue("@Name", fileName);

            // Execute command
            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        /// <summary>
        /// Get contents of file
        /// </summary>
        public static string FileContentSelect(string virtualPath)
        {
            int codeSampleId = GetCodeSampleId(virtualPath);
            return CodeSample.Get(codeSampleId).TryItCode;
        }


        /// <summary>
        /// Update File ccntent
        /// </summary>
        public static void FileContentUpdate(string virtualPath, string content)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Break virtualPath
            string path = VirtualPathUtility.GetDirectory(virtualPath);
            string fileName = VirtualPathUtility.GetFileName(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "UPDATE VirtualFiles SET Content=@Content WHERE Path=@Path AND Name=@Name";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameter
            cmd.Parameters.AddWithValue("@Path", path);
            cmd.Parameters.AddWithValue("@Name", fileName);
            cmd.Parameters.AddWithValue("@Content", content);

            // Execute command
            using (con)
            {
                con.Open();
                cmd.ExecuteScalar();
            }
        }


        /// <summary>
        /// Check if directory exists in database
        /// </summary>
        public static bool DirectoryExists(string virtualPath)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "SELECT Path FROM VirtualDirectories WHERE Path=@Path";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameter
            cmd.Parameters.AddWithValue("@Path", virtualPath);

            // Execute command
            bool result;
            using (con)
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                result = reader.HasRows;
            }
            return result;
        }

        /// <summary>
        /// Create a new directory
        /// </summary>
        public static void DirectoryInsert(string virtualPath, string path)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "INSERT VirtualDirectories (Path,ParentPath) VALUES (@Path,@ParentPath)";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameters
            cmd.Parameters.AddWithValue("@Path", VirtualPathUtility.Combine(virtualPath, path));
            cmd.Parameters.AddWithValue("@ParentPath", virtualPath);

            // Execute command
            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Deletes a directory
        /// </summary>
        public static void DirectoryDelete(string virtualPath)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "DELETE VirtualDirectories WHERE Path + '/'=@Path OR ParentPath=@Path";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath);

            // Execute command
            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }




        /// <summary>
        /// Get a directory
        /// </summary>
        public static List<SqlVirtualDirectory> DirectorySelect()
        {
            List<SqlVirtualDirectory> dirs = new List<SqlVirtualDirectory>();

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "SELECT Path FROM VirtualDirectories";
            SqlCommand cmd = new SqlCommand(commandText, con);

            using (con)
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    dirs.Add(new SqlVirtualDirectory((string)reader["Path"]));
            }

            return dirs;
        }


        /// <summary>
        /// Get all files in a directory
        /// </summary>
        public static List<SqlVirtualFile> DirectorySelectFiles(string virtualPath)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "SELECT Path,Name FROM VirtualFiles "
                + "WHERE Path=@Path ORDER BY Path";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameter
            cmd.Parameters.AddWithValue("@Path", virtualPath);

            // Execute command
            List<SqlVirtualFile> files = new List<SqlVirtualFile>();
            using (con)
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    string fullName = VirtualPathUtility.Combine((string)reader["Path"], (string)reader["Name"]);
                    files.Add(new SqlVirtualFile(fullName));
                }
            }

            return files;
        }

        /// <summary>
        /// Retrieves all subdirectories for a directory
        /// </summary>
        public static List<SqlVirtualDirectory> DirectorySelectDirectories(string virtualPath)
        {
            // Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath);

            // Initialize command
            SqlConnection con = new SqlConnection(_connectionString);
            string commandText = "SELECT Path FROM VirtualDirectories "
                + "WHERE ParentPath=@Path ORDER BY Path";
            SqlCommand cmd = new SqlCommand(commandText, con);

            // Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath);

            // Execute command
            List<SqlVirtualDirectory> dirs = new List<SqlVirtualDirectory>();
            using (con)
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    dirs.Add(new SqlVirtualDirectory((string)reader["Path"]));
            }

            return dirs;
        }

        /// <summary>
        /// Returns all files and subdirectories from a directory
        /// </summary>
        public static ArrayList DirectorySelectChildren(string virtualPath)
        {
            ArrayList filesAndDirs = new ArrayList();

            List<SqlVirtualDirectory> dirs = DirectorySelectDirectories(virtualPath);
            foreach (SqlVirtualDirectory dir in dirs)
                filesAndDirs.Add(dir);

            List<SqlVirtualFile> files = DirectorySelectFiles(virtualPath);
            foreach (SqlVirtualFile file in files)
                filesAndDirs.Add(file);

            return filesAndDirs;
        }

    }
}