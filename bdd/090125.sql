CREATE OR REPLACE VIEW reservation_vol AS
SELECT dr.*
FROM vols v
    JOIN segments_vol sv ON sv.vol_id=v.vol_id
    JOIN instances_vols iv ON sv.segment_id=iv.segment_id
    JOIN detail_reservation dr ON dr.instance_id=iv.instance_id
    JOIN reservations r ON dr.reservation_id=r.reservation_id;