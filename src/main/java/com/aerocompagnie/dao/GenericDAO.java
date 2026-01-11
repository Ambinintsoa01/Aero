package com.aerocompagnie.dao;

import com.aerocompagnie.config.DatabaseConfig;
import java.lang.reflect.Field;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class GenericDAO {

    // SAUVEGARDER (INSERT)
    public static boolean save(Object obj, String tableName) {
        Class<?> clazz = obj.getClass();
        Field[] fields = clazz.getDeclaredFields();
        
        StringBuilder columns = new StringBuilder();
        StringBuilder values = new StringBuilder();
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            for (Field field : fields) {
                field.setAccessible(true);
                // On ignore l'ID car il est SERIAL (auto-increment)
                if (!field.getName().toLowerCase().contains("id")) {
                    columns.append(field.getName()).append(",");
                    values.append("?,");
                }
            }
            // Retirer les dernières virgules
            columns.setLength(columns.length() - 1);
            values.setLength(values.length() - 1);

            String sql = "INSERT INTO " + tableName + " (" + columns + ") VALUES (" + values + ")";
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                int index = 1;
                for (Field field : fields) {
                    if (!field.getName().toLowerCase().contains("id")) {
                        ps.setObject(index++, field.get(obj));
                    }
                }
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // MISE À JOUR (UPDATE)
    public static boolean update(Object obj, String tableName, String idColumnName) {
        Class<?> clazz = obj.getClass();
        Field[] fields = clazz.getDeclaredFields();

        StringBuilder setClause = new StringBuilder();
        Object idValue = null;

        List<Field> updatableFields = new ArrayList<>();
        for (Field field : fields) {
            field.setAccessible(true);
            if (field.getName().equalsIgnoreCase(idColumnName)) {
                try {
                    idValue = field.get(obj);
                } catch (IllegalAccessException e) {
                    throw new RuntimeException(e);
                }
                continue;
            }
            try {
                Object value = field.get(obj);
                if (value != null) {
                    updatableFields.add(field);
                    setClause.append(field.getName()).append(" = ?,");
                }
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        }

        if (idValue == null) {
            throw new IllegalArgumentException("ID column value not found on object for update");
        }

        if (setClause.length() == 0) {
            // nothing to update
            return true;
        }
        setClause.setLength(setClause.length() - 1); // remove last comma
        String sql = "UPDATE " + tableName + " SET " + setClause + " WHERE " + idColumnName + " = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            for (Field field : updatableFields) {
                field.setAccessible(true);
                ps.setObject(index++, field.get(obj));
            }
            ps.setObject(index, idValue);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // LISTER (SELECT ALL)
    public static <T> List<T> findAll(Class<T> clazz, String tableName) {
        List<T> list = new ArrayList<>();
        String sql = "SELECT * FROM " + tableName;

        try (Connection conn = DatabaseConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                T obj = clazz.getDeclaredConstructor().newInstance();
                for (Field field : clazz.getDeclaredFields()) {
                    field.setAccessible(true);
                    field.set(obj, mapColumnValue(rs, field.getName(), field.getType()));
                }
                list.add(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // LIRE PAR ID (SELECT ONE)
    public static <T> T findById(int id, Class<T> clazz, String tableName, String idColumnName) {
        String sql = "SELECT * FROM " + tableName + " WHERE " + idColumnName + " = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    T obj = clazz.getDeclaredConstructor().newInstance();
                    for (Field field : clazz.getDeclaredFields()) {
                        field.setAccessible(true);
                        field.set(obj, mapColumnValue(rs, field.getName(), field.getType()));
                    }
                    return obj;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Object mapColumnValue(ResultSet rs, String columnName, Class<?> targetType) throws SQLException {
        if (targetType.equals(LocalDate.class)) {
            Date date = rs.getDate(columnName);
            return date != null ? date.toLocalDate() : null;
        }
        if (targetType.equals(LocalDateTime.class)) {
            Timestamp ts = rs.getTimestamp(columnName);
            return ts != null ? ts.toLocalDateTime() : null;
        }
        if (targetType.equals(Integer.class) || targetType.equals(int.class)) {
            return rs.getObject(columnName, Integer.class);
        }
        if (targetType.equals(Long.class) || targetType.equals(long.class)) {
            return rs.getObject(columnName, Long.class);
        }
        if (targetType.equals(Double.class) || targetType.equals(double.class)) {
            return rs.getObject(columnName, Double.class);
        }
        if (targetType.equals(Float.class) || targetType.equals(float.class)) {
            return rs.getObject(columnName, Float.class);
        }
        return rs.getObject(columnName);
    }

    // SUPPRIMER (DELETE)
    public static boolean delete(int id, String tableName, String idColumnName) {
        String sql = "DELETE FROM " + tableName + " WHERE " + idColumnName + " = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // SUPPRIMER PAR CLÉ TEXTE (ex: code IATA)
    public static boolean deleteByString(String value, String tableName, String idColumnName) {
        String sql = "DELETE FROM " + tableName + " WHERE " + idColumnName + " = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}