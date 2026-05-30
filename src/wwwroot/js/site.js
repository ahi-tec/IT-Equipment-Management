// IT Equipment Management - site.js
$(document).ready(function () {
    // Initialize DataTables
    if ($('#dataTable').length) {
        $('#dataTable').DataTable({
            language: {
                search: "Search:",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ - _END_ / _TOTAL_",
                paginate: { first: "First", last: "Last", next: "»", previous: "«" },
                zeroRecords: "No matching records found",
                emptyTable: "No data available"
            },
            pageLength: 15,
            responsive: true
        });
    }

    // Initialize Select2
    if ($.fn.select2) {
        $('.select2').select2({ theme: 'default', width: '100%' });
    }

    // Sidebar toggle
    $('#sidebarToggle').on('click', function () {
        if ($(window).width() >= 992) {
            // Desktop: toggle collapsed mode
            $('.sidebar').toggleClass('collapsed');
        } else {
            // Mobile: toggle show/hide
            $('.sidebar').toggleClass('show');
        }
    });

    // Close sidebar on outside click (mobile)
    $(document).on('click', function (e) {
        if ($(window).width() < 992) {
            if (!$(e.target).closest('.sidebar, #sidebarToggle').length) {
                $('.sidebar').removeClass('show');
            }
        }
    });

    // Auto-hide alerts
    setTimeout(function () {
        $('.alert-dismissible').fadeOut(500);
    }, 5000);

    // Confirm delete actions
    $('form[data-confirm]').on('submit', function (e) {
        e.preventDefault();
        var form = this;
        Swal.fire({
            title: 'Confirm',
            text: $(this).data('confirm') || 'Are you sure you want to proceed?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#667eea',
            cancelButtonText: 'Cancel',
            confirmButtonText: 'Confirm'
        }).then(function (result) {
            if (result.isConfirmed) form.submit();
        });
    });
});
