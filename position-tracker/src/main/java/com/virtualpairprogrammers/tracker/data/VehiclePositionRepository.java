/*

@author : rejupillai

*/


package com.virtualpairprogrammers.tracker.data;

import com.virtualpairprogrammers.tracker.domain.VehiclePosition;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface VehiclePositionRepository extends CrudRepository<VehiclePosition, Long> {

    List<VehiclePosition> findByName(String name);

}
